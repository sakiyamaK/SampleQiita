//
//  AppDelegate.swift
//  SampleQiita
//
//  Created by sakiyamaK on 2020/11/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var loginViewController: LoginViewController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    guard let loginViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController else {
      fatalError()
    }
    self.loginViewController = loginViewController
    let navigationController = UINavigationController(rootViewController: loginViewController)
    let window = UIWindow()
    window.rootViewController = navigationController
    window.makeKeyAndVisible()

    self.window = window
    
    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    guard let loginViewController = self.loginViewController else {
      return true
    }
    loginViewController.openURL(url)
    return true
  }
}

