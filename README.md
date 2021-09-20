
# App Challenge Week 15 - Phoenix Chat App
**Deadline: Friday**

This is a step-by-step challenge that guides you through the entire process of the App Challenge.

**Important: Aside from the previous App Challenges, you will also be using what you've learned from hands-on activities**

# What You Will Be Making - An app that displays the real-time weather data of a city
<img width="1381" alt="weather data" src="https://user-images.githubusercontent.com/87120195/131660031-e743b9cc-3520-4eec-a9a0-3b264439c58a.png">



# What You Will Be Learning

1. Networking - https://www.youtube.com/watch?v=Rqr3w8scm2E
2. JSON - https://www.youtube.com/watch?v=_TrPJQWD8qs
3. APIS - https://www.youtube.com/watch?v=s7wmiS2mSXY


# Important keywords
1.Firebase
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

Step 3: Start a new project and name it Phoenix Chat
<img width="1322" alt="Screen Shot 2021-09-20 at 5 53 20 PM" src="https://user-images.githubusercontent.com/87120195/133984924-89e25bd2-50f1-4d94-b0a5-7adae1e1b497.png">

Step 4: Keep clicking continue, until you reach this state
<img width="1358" alt="Screen Shot 2021-09-20 at 5 53 53 PM" src="https://user-images.githubusercontent.com/87120195/133984987-1887e6a1-b94c-47fe-b529-07fe204005b7.png">

Step 5: Create a new iOS App by clicking on iOS
<img width="1137" alt="Screen Shot 2021-09-20 at 5 55 04 PM" src="https://user-images.githubusercontent.com/87120195/133985060-937e27ba-511c-4068-a6bb-5e19175c155b.png">

Step 6: Copy and past your bundle Identifier that you can find from your Xcode project in the Bundle IOS ID field
<img width="449" alt="Screen Shot 2021-09-20 at 6 01 48 PM" src="https://user-images.githubusercontent.com/87120195/133985316-9fdf383f-d4c1-4d5a-b44f-c38ec0774b4a.png">

<img width="1440" alt="Screen Shot 2021-09-20 at 5 55 08 PM" src="https://user-images.githubusercontent.com/87120195/133985095-341a2496-207d-4d63-ac3e-0ee7889bfe9c.png">

Step 7: Proceed to the rest of the Firebase setup and follow the rest of the instruction from Firebase
<img width="1440" alt="Screen Shot 2021-09-20 at 5 57 31 PM" src="https://user-images.githubusercontent.com/87120195/133985372-8dd7c5ca-c9c0-4fbb-965e-058853a29bac.png">

Step 8: After finishing all the setup, go to your newly created project and go the Authentication section and enable the Email/Password Sign-in method
<img width="1401" alt="Screen Shot 2021-09-20 at 6 05 38 PM" src="https://user-images.githubusercontent.com/87120195/133985746-7e1fdab6-9e0c-40e8-8a5c-8ea70c7b6228.png">

Step 9: Navigate to your project directory and folder and initialize your pod using the command pod init in the terminal. Open the new pod file copy and paste the code under the Pods for Phoenix-Chat

pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Firestore'
pod 'SVProgressHUD'
pod 'ChameleonFramework'


Note: Make sure you uncomment the _use_frameworks and target platform :ios, '9.0'_

Step 4: Go back to terminal again and now do _pod install_. Wait until it's done. Then open your project using .xcworkspace

**Part 2**


        

Final step: Run the app and make sure it displays real-time data of a sample weather data of San Francisco and test it by changing the location of the city



Copyright 2021 Hikre, Inc. Hikre School
