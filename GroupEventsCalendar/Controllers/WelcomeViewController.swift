//
//  WelcomeViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 01/09/2021.
//

import Foundation
import UIKit
import AuthenticationServices


class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!

    
     override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        performExistingAccountSetupFlows()
    }
    
//    @IBAction func signInWithAppleButton(_ sender: ASAuthorizationAppleIDButton) {
//    }
    
//    func performExistingAccountSetupFlows() {
//        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]
//
//        let authorisationController = ASAuthorizationController(authorizationRequests: requests)
//        authorisationController.delegate = self
//        authorisationController.presentationContextProvider = self
//        authorisationController.performRequests()
//    }
    
    
}
