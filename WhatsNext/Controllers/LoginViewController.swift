//
//  LoginViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//
import UIKit
import Foundation
class LoginViewController: UIViewController {
    var registerActive: Bool = false

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var needAccountButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    private var network: Network = Network()
    override func viewDidLoad() {

    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
    registerButton.isHidden = true
    confirmPasswordField.isHidden = true
    firstNameTextField.isHidden = true
    lastNameTextField.isHidden = true

    initializeData()
  }

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

    @IBAction func didTapRegisterButton(_ sender: Any) {
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
    private func initializeData() {

  }

  // MARK: - IBAction
  @IBAction func didTapSignInButton(_ sender: Any) {
    let login: Login = Login(email: userNameField.text!, password: passwordField.text!)
    var loggedin = false
    Network.shared.login(login: login) { isSuccess in

        loggedin = UserDefaults.standard.bool(forKey: "isLoggedIn")

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

    func showPopup(isSuccess: Bool) {
      let successMessage = "Congratulations! You logged in successully."
      let errorMessage = "Something went wrong. Please try again"
      let alert = UIAlertController(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
}
