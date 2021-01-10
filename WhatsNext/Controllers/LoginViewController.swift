//
//  LoginViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//
import UIKit
import Foundation
/// view controller for the login view
class LoginViewController: UIViewController, UITextFieldDelegate {
    var registerActive: Bool = false
    var labelActive: Bool = false
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var needAccountButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    /// Provides network functionality
    private var network: Network = Network()
    override func viewDidLoad() {

    super.viewDidLoad()
        self.userNameField.delegate = self
        self.passwordField.delegate = self
        self.confirmPasswordField.delegate = self
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self

  }

  override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
    registerButton.isHidden = true
    confirmPasswordField.isHidden = true
    firstNameTextField.isHidden = true
    lastNameTextField.isHidden = true
    errorLabel.isHidden = true
  }
    /// Listener to make sure keyboard closes when return is pressed on the keyboard
    /// - Parameter textField: the textfield
    /// - Returns: false
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }

    /// Listener for want to register button, shows more textfields when users need to register
    /// - Parameter sender: sender
    @IBAction func didTapNeedAccountButton(_ sender: Any) {
        if registerActive {
            registerButton.isHidden = true
            confirmPasswordField.isHidden = true
            firstNameTextField.isHidden = true
            lastNameTextField.isHidden = true
            loginButton.isHidden = false
            registerActive = false
            needAccountButton.setTitle("Need an account?", for: .normal)
        } else {
            registerButton.isHidden = false
            confirmPasswordField.isHidden = false
            firstNameTextField.isHidden = false
            lastNameTextField.isHidden = false
            loginButton.isHidden = true
            registerActive = true
            needAccountButton.setTitle("Already have an account?", for: .normal)
        }

    }

    /// Listener for register button
    /// - Parameter sender: sender
    @IBAction func didTapRegisterButton(_ sender: Any) {

        do {
            try Validations.validate(username: firstNameTextField.text!)
            try Validations.email(userNameField.text!)
            try Validations.validate(username: lastNameTextField.text!)
            try Validations.validatePassword(password: passwordField.text!, password2: confirmPasswordField.text!)

        } catch {
            errorLabel.isHidden = false
            errorLabel.text = error.localizedDescription
            showPopup(isSuccess: false, optionalMessage: error.localizedDescription)
            return
        }

        let register: Register = Register(email: userNameField.text!,
        password: passwordField.text!, passwordConfirmation: confirmPasswordField.text!,
        firstName: firstNameTextField.text!, lastName: lastNameTextField.text!
        )
        Network.shared.register(register: register) { isSuccess in

            let loggedin = UserDefaults.standard.bool(forKey: "isLoggedIn")

            if !loggedin {
                self.showPopup(isSuccess: loggedin)

            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")

                    // This is to get the SceneDelegate object from your view controller
                    // then call the change root view controller function to change to main tab bar
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }

        }

    }

    /// Listener for login button
    /// - Parameter sender: object that sent it
  @IBAction func didTapSignInButton(_ sender: Any) {
    let login: Login = Login(email: userNameField.text!, password: passwordField.text!)
    var loggedin = false
    Network.shared.login(login: login) { isSuccess in

        loggedin = UserDefaults.standard.bool(forKey: "isLoggedIn")

        if !loggedin {
            self.showPopup(isSuccess: loggedin, optionalMessage: login.email)

        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")

                // This is to get the SceneDelegate object from your view controller
                // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    }

  }

    /// Shows popup message when something goes wrong during login
    /// - Parameters:
    ///   - isSuccess: indicated whether the message will be an error or success message
    ///   - optionalMessage: custom message content
    func showPopup(isSuccess: Bool, optionalMessage: String = "") {
      let successMessage = "Congratulations! You logged in successully. Welcome, "+optionalMessage
      let errorMessage = "Something went wrong. Please try again. "+optionalMessage
      let alert = UIAlertController(title: isSuccess ? "Success": "Error",
                                 message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
}
