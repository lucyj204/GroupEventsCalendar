//
//  RegisterViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 01/09/2021.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "goToGroups", sender: self)
                }
            }
            
        }
        
    }
    
}
