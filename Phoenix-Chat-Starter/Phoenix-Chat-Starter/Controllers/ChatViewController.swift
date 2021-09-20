//
//
//  ChatViewController.swift
//  Phoenix-Chat-App
//
//  Created by jeazous on 9/20/21.
//

import UIKit


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

        
    
        
        
    }


    
    //MARK: - TableView Delegate Methods
    
    
    // TableView cellForRowAt for displaying data on the table view cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageAtIndexPathRow = messageArray[indexPath.row]
        
        
        // Paste here the complete configuration for cellForRowAt
        
        
        
        
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
        
        self.messageTextfield.endEditing(true)
        self.messageTextfield.isEnabled = true
        self.sendButton.isEnabled = true
        self.messageTextfield.text = ""
        self.configureTableView()
        
        
        // This block of code will handle the storing of the new message on our Firestore database
        // Paste here
        
        
        
        
        
        
        
    }
    
    
    // This method loads all the messages from Firestore database and updates our table view cells
    func retrieveMessages() {
        
     
     // Paste the block of code that handles the loading of the messages from our Firestore database and that loads on tableview

        
        
        
        
        
        
        
    }


    
    //MARK - Log Out pressed
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        // This alert controller requires an extra step to confirm the user's logout decision
        //1. Add the text field. You can configure it however you need.
        let alertController = UIAlertController(title: "Signing out", message: "Phoenix is looking forward to see you again.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alertController.addTextField { (textField) in
            textField.placeholder = "Type exactly \"Arrivederci\" to complete."
            
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alertController.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { [weak alertController] (_) in
            
            let textField = alertController?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            
            
            if textField?.text  == "Arrivederci" {
                
                do {
                   
                    
                    // Paste here the line of code that logs out the user from the app
                
                    
                    
                    
                    
                    
                    
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
