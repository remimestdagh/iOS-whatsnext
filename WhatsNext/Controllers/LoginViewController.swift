//
//  LoginViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation
class LoginViewController: UIViewController {
  
    @IBOutlet weak var userNameTextField: CustomTextField!
  @IBOutlet weak var passwordTextField: CustomTextField!
  @IBOutlet weak var signInButton: UIButton!
  let viewModel = LoginViewModel()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    initializeData()
  }
  
  private func initializeData() {
    /// Placeholder text
    userNameTextField.placeholderText = "Username"
    passwordTextField.placeholderText = "Password"
    
    /// Make the buttons more catchy
    signInButton.corner()
    
    /// Delegate the protocol
    viewModel.delegate = self
  }
  
  // MARK: - IBAction
  @IBAction func didTapSignInButton(_ sender: Any) {
    viewModel.login(username: userNameTextField.text, password: passwordTextField.text, type: .normal)
  }
}

// MARK: - Show result
extension LoginViewController: LoginResultProtocol {
  
  func showPopup(isSuccess: Bool, user: User? = nil, type: LoginType) {
    let successMessage = "\(user?.username ?? ""). You logged in successully with \(type.name). "
    let errorMessage = "Something went wrong. Please try again"
    let alert = UIAlertController(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func success(user: User?, type: LoginType) {
    showPopup(isSuccess: true, user: viewModel.user, type: type)
  }
  
  func error(error: Error, type: LoginType) {
    showPopup(isSuccess: false, type: type)
  }
}
