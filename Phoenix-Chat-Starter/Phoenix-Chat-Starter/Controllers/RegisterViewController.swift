//
//  RegisterViewController.swift
//  Phoenix-Chat-App
//
//  Created by jeazous on 9/20/21.
//

import UIKit



class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Putting corner radius on our register button
        registerButton.layer.cornerRadius = registerButton.frame.size.height / 2
        registerButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        

        //Set up a new user on our Firebase database

        
        
        
        
        
        
    } 
    
    
}



