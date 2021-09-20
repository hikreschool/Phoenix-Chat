
# App Challenge Week 15 - Phoenix Chat App
**Deadline: Friday**

This is a step-by-step challenge that guides you through the entire process of the App Challenge.

**Important: Aside from the previous App Challenges, you will also be using what you've learned from hands-on activities**

# What You Will Be Making - A simple chat app the shows messages in real-time
<img width="1381" alt="weather data" src="app-challenge-final.gif">




# What will you be learning

1. Firebase
2. Authentication
3. Firestore
4. Web Service
5. Backend Provider


# Coding advice

1. If you can, use a piece of paper to sketch your pseudocode (human-readable language)
2. Start writing code (start small and divide and conquer)
3. Start on simple tasks like UI-related code
4. THen, proceed with the logic of the app
5. Be mindful on doing one particular task at a time
6. Use Stackoverflow or complementary resources when stuck or in case of an error


# Steps

**Part 1 Firebase **

Step 1: Download the Starter project

Step 2: Create an account on Firebase at https://firebase.google.com/

<img width="1314" alt="Screen Shot 2021-09-20 at 5 51 04 PM" src="https://user-images.githubusercontent.com/87120195/133983949-d3a7a34a-fb07-4195-b1ad-bc39b73bf36e.png">

Step 3: Start a new project and name it _Phoenix Chat_
<img width="1322" alt="Screen Shot 2021-09-20 at 5 53 20 PM" src="https://user-images.githubusercontent.com/87120195/133984924-89e25bd2-50f1-4d94-b0a5-7adae1e1b497.png">

Step 4: Keep clicking continue, until you reach this state
<img width="1358" alt="Screen Shot 2021-09-20 at 5 53 53 PM" src="https://user-images.githubusercontent.com/87120195/133984987-1887e6a1-b94c-47fe-b529-07fe204005b7.png">

Step 5: Create a new _iOS App_ by clicking on iOS
<img width="1137" alt="Screen Shot 2021-09-20 at 5 55 04 PM" src="https://user-images.githubusercontent.com/87120195/133985060-937e27ba-511c-4068-a6bb-5e19175c155b.png">

Step 6: Copy and past your _bundle Identifier_ that you can find from your Xcode project in the Bundle IOS ID field
<img width="449" alt="Screen Shot 2021-09-20 at 6 01 48 PM" src="https://user-images.githubusercontent.com/87120195/133985316-9fdf383f-d4c1-4d5a-b44f-c38ec0774b4a.png">

<img width="1440" alt="Screen Shot 2021-09-20 at 5 55 08 PM" src="https://user-images.githubusercontent.com/87120195/133985095-341a2496-207d-4d63-ac3e-0ee7889bfe9c.png">

Step 7: Proceed to the rest of the Firebase setup and follow the rest of the instruction from Firebase
<img width="1440" alt="Screen Shot 2021-09-20 at 5 57 31 PM" src="https://user-images.githubusercontent.com/87120195/133985372-8dd7c5ca-c9c0-4fbb-965e-058853a29bac.png">

Step 8: After finishing all the setup, go to your newly created project and go the Authentication section and enable the _Email/Password Sign-in method_
<img width="1401" alt="Screen Shot 2021-09-20 at 6 05 38 PM" src="https://user-images.githubusercontent.com/87120195/133985746-7e1fdab6-9e0c-40e8-8a5c-8ea70c7b6228.png">

Step 9: Navigate to your project directory and folder and initialize your pod using the command _pod init _in the terminal. 
Open the new pod file and copy and paste the code under the Pods for Phoenix-Chat

pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Firestore'
pod 'SVProgressHUD'
pod 'ChameleonFramework'

**Note**: Make sure you uncomment the _use_frameworks and target platform :ios, '9.0'_

Step 10: Go back to terminal again and now do _pod install_. Wait until it's done. Then open your project using _.xcworkspace_



**Part 2 - WelcomeViewController**

Step 11: On the WelcomeViewController file, import Firebase on the top

Step 12: Paste this code inside ViewDidLoad()
    

             if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "goToChat", sender: self)
        }
  


**Part 3 - RegisterViewController**

Step 13: On the RegisterViewController file, import Firebase on the top

Step 14: Paste this code inside registerPressed()
        
                Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Registration Successful!")
                
               
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }



**Part 4 - LoginViewController**

Step 15: On the LoginViewController file, import Firebase on the top

Step 16: Paste this code inside loginPressed()
        
              Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Log in successful!")
                
                
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
                
            }
            
        }


**Part 4 - ChatViewController**

Step 17: Import these on top of the file

    import Firebase
    import ChameleonFramework
    import AVFoundation

Step 18: Go to cellForRowAt delegate method by our tableview and paste this block of code

      
        if messageAtIndexPathRow.sender == Auth.auth().currentUser?.email as String? {
            
            //Set background to blue if message is from logged in user.
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "customMessageCell2") as! SecondCustomMessageCell
            
            // Displays data to cell UI
            cell2.messageBody.text = messageArray[indexPath.row].messageBody
            cell2.senderUsername.text = messageArray[indexPath.row].sender
            cell2.avatarImageView.image = UIImage(named: "owl2")
            
            //Set background to orange if message is from the current user.
            cell2.messageBackground.backgroundColor = UIColor.flatBlue()
            
            return cell2
            
        } else {
            
        
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell") as! CustomMessageCell
            
            // Displays data to cell UI
            cell.messageBody.text = messageArray[indexPath.row].messageBody
            cell.senderUsername.text = messageArray[indexPath.row].sender
            cell.avatarImageView.image = UIImage(named: "owl")
            
            //Set background to orange if message is from another user.
            cell.messageBackground.backgroundColor = UIColor.flatOrange()
            
            return cell
        }
        
Step 19: For storing every message on our Firestore database, paste this block of code on our sendPressed() 

       let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Messages").addDocument(data: ["Sender":Auth.auth().currentUser?.email, "Message":messageTextfield.text!, "Time": Timestamp().dateValue()])
        
        firestoreDB.collection("Messages").order(by: "Time")
        
Step 20: For loading every message from our Firestore database, paste this block of code on our retrieveMessages()

       
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
        
Step 21: To log out a user from the chat app, paste this line of code in our logOutPressed() where it says _paste here_

    try Auth.auth().signOut()

Step 22: Invoke or call retrieveMessages() method on the bottom of our viewDidLoad()


Final step: Run the app and try sending a couple of chats and make sure it displays the right message. 

Bonus: Try running the app on an iPhone 11 and iPhone 8 simulators simultaneously and create two different accounts from both devices and try chatting each other!



Copyright 2021 Hikre, Inc. Hikre School
