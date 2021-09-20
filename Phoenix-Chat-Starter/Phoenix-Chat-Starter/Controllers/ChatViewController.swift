//
//
//  ChatViewController.swift
//  Phoenix-Chat-App
//
//  Created by jeazous on 9/20/21.
//

import UIKit
import Firebase
import ChameleonFramework
import AVFoundation

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // We've already declared instance variables for you
    var messageArray : [Message] = [Message]()
    var player: AVAudioPlayer?
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    var topButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides the back button on our chat screen to prevent accidental returns
        self.navigationItem.hidesBackButton = true
        
        
        // Fully conforming to the tableview delegate
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        // Fully conforming to our text field delegage
        messageTextfield.delegate = self
    
        // Registering our two custom cells
        messageTableView.register(UINib(nibName: "SecondMessageCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell2")
    
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell")
 
        
        // Creating a tap recognizer every time a user clicks on any part of the table view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tableViewTapped))
        
        // This officially adds it to our table view
        messageTableView.addGestureRecognizer(tapGesture)
        
        // More tableview and textfield configurations
        messageTableView.separatorStyle = .none
        messageTextfield.layer.cornerRadius = 16
        messageTextfield.clipsToBounds = true
        
        // Adjusts the height of tableview when needed
        configureTableView()
        
        // making sure the send message button is disabled at launch
        sendButton.isEnabled = false
        retrieveMessages()		
    }


    
    //MARK: - TableView Delegate Methods
    
    
    // TableView cellForRowAt for displaying data on the table view cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageAtIndexPathRow = messageArray[indexPath.row]
        if messageAtIndexPathRow.sender == Auth.auth().currentUser?.email as String? {
            
            // set background to blue if message is from logged in user
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "customMessageCell2") as! SecondCustomMessageCell
            // displays the data to cell UI
            cell2.messageBody.text = messageArray[indexPath.row].messageBody
            cell2.senderUsername.text = messageArray[indexPath.row].sender
//            cell2.avatarImageView.image = UIImage(named: "owl2")
            
            // Set the background color to blue if message is from current user
            cell2.messageBackground.backgroundColor = UIColor.flatBlue()
            
            return cell2
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell") as! CustomMessageCell
            cell.messageBody.text = messageArray[indexPath.row].messageBody
            cell.senderUsername.text = messageArray[indexPath.row].sender
   //         cell.avatarImageView.image = UIImage(named: "owl")
            
            // set background color to orange if message is from another user
            cell.messageBackground.backgroundColor = UIColor.flatOrange()
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }

    
    //TODO: Declare configureTableView here:
    
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
        

    }
    
    

    //MARK: - TextField Delegate Methods

    func textFieldDidBeginEditing(_ textField: UITextField) {

        sendButton.isEnabled = true
        
        UIView.animate(withDuration: 0.2) {
            self.heightConstraint.constant = 400
            self.view.layoutIfNeeded()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.heightConstraint.constant = 80
            self.view.layoutIfNeeded()
        }
    }
    
    
    

    // Plays a futuristic sound every time the there's a new message or when the view loads
    func playChatSound() {
        guard let url = Bundle.main.url(forResource: "futuristic_ringtone", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

         
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    // This simple methods allows the table view to scroll to the bottom every time there's a new message
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messageArray.count-1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    //MARK: - Send & Recieve Messages from Firebase

    @IBAction func sendPressed(_ sender: AnyObject) {
        
        print("send pressed is tapped")

        playChatSound()
 
        // This block of code will handle the storing of the new message on our Firestore database
        // Paste here
        
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Messages").addDocument(data: ["Sender":Auth.auth().currentUser?.email! as Any, "Message":messageTextfield.text!, "Time": Timestamp().dateValue()])
            
        firestoreDB.collection("Messages").order(by: "Time")
        
        self.messageTextfield.endEditing(true)
        self.messageTextfield.isEnabled = true
        self.sendButton.isEnabled = true
        self.messageTextfield.text = ""
        self.configureTableView()
        
    }
    
    
    // This method loads all the messages from Firestore database and updates our table view cells
    func retrieveMessages() {
        
     
     // Paste the block of code that handles the loading of the messages from our Firestore database and that loads on tableview

        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Messages").order(by: "Time", descending: false).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let snapshot = snapshot {
                let documents = snapshot.documents
                var newMessageArray = [Message]()
                for document in documents {
                    guard let messageSender = document.data()["Sender"] as? String else { return }
                    guard let messageBody = document.data()["Message"] as? String else { return }
                    let message = Message()
                    message.messageBody = messageBody
                    message.sender = messageSender
                    newMessageArray.append(message)
                }
                self.playChatSound()
                self.messageArray = newMessageArray
                self.messageTableView.reloadData()
                self.scrollToBottom()
            }
        }

    }


    
    //MARK - Log Out pressed
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        // This alert controller requires an extra step to confirm the user's logout decision
        //1. Add the text field. You can configure it however you need.
        let alertController = UIAlertController(title: "Signing out", message: "Phoenix is looking forward to see you again.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alertController.addTextField { (textField) in
            textField.placeholder = "Type exactly \"Mama\" to complete."
            
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alertController.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { [weak alertController] (_) in
            
            let textField = alertController?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            
            
            if textField?.text  == "Mama" {
                
                do {
                   
                    
                    // Paste here the line of code that logs out the user from the app
                
                    
                    try Auth.auth().signOut()
                    
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    
                }
                catch {
                    print("error: there was a problem logging out")
                }
    
                
            } else {
                
                print("You misspelled Arrivederci.")
            }
            
        }))
        
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alertController, animated: true)
        
        
    }
    


}
