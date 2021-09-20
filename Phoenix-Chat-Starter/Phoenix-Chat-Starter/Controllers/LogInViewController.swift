//
//  LoginViewController.swift
//  Phoenix-Chat-App
//
//  Created by jeazous on 9/20/21.
//


import UIKit


class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
        loginButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    //Log in an existing user
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        
        // This block of will use Firebase authentication to sign in or register a new user into our chat app
        

        
        
        
    }
    


    
}  
