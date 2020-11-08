//
//  LoginViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//
import UIKit
import Foundation
class LoginViewController: UIViewController {
  
 
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    private var network: Network = Network()
    override func viewDidLoad() {
    
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    initializeData()
  }
  
  private func initializeData() {
    
    /// Delegate the protocol
    //viewModel.delegate = self
  }
  
  // MARK: - IBAction
  @IBAction func didTapSignInButton(_ sender: Any) {
    print("joost")
    let login: Login = Login(email: userNameField.text!, password: passwordField.text!)
    self.network.login(login: login)
    print("kaas")
  }
}
