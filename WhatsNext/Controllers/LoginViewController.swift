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

  }

  // MARK: - IBAction
  @IBAction func didTapSignInButton(_ sender: Any) {
    print("joost")
    let login: Login = Login(email: userNameField.text!, password: passwordField.text!)
    self.network.login(login: login)
    //UserDefaults.standard.set(true, forKey: "isLoggedIn")
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")

        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)

  }
}
