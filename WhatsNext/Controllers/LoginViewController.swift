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
    @IBOutlet weak var needAccountButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var confirmPasswordField: UITextField!
    private var network: Network = Network()
    override func viewDidLoad() {

    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
    registerButton.isHidden = true
    confirmPasswordField.isHidden = true

    initializeData()
  }

    @IBAction func didTapNeedAccountButton(_ sender: Any) {
        registerButton.isHidden = false
        confirmPasswordField.isHidden = false
        needAccountButton.isHidden = true

    }

    @IBAction func didTapRegisterButton(_ sender: Any) {
        let register = Register(email: userNameField.text!,
        password: passwordField.text!, confirmPassword : confirmPasswordField.text!)
    }
    private func initializeData() {

  }

  // MARK: - IBAction
  @IBAction func didTapSignInButton(_ sender: Any) {
    let login: Login = Login(email: userNameField.text!, password: passwordField.text!)
    self.network.login(login: login)

    let loggedin = UserDefaults.standard.bool(forKey: "isLoggedIn")

    if(!loggedin) {
        showPopup(isSuccess: loggedin)

    } else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")

            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
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
