//
//  ViewController.swift
//  SampleQiita
//
//  Created by sakiyamaK on 2020/11/07.
//

import UIKit

final class LoginViewController: UIViewController {

  @IBOutlet private weak var loginButton: UIButton! {
    didSet {
      loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func openURL(_ url: URL) {
    guard let queryItems = URLComponents(string: url.absoluteString)?.queryItems,
          let code = queryItems.first(where: {$0.name == "code"})?.value,
          let getState = queryItems.first(where: {$0.name == "state"})?.value,
          getState == API.shared.qiitState
    else {
      return
    }
    API.shared.postAccessToken(code: code) { accessToken, error  in
      if let _error = error {
        //TODO: エラー表示
        return
      }
      guard let _accessToken = accessToken,
            let vc = UIStoryboard.init(name: "Items", bundle: nil).instantiateInitialViewController()
      else {
        //TODO: エラー表示
        return
      }
      UserDefaults.standard.qiitaAccessToken = _accessToken.token
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

private extension LoginViewController {
  @objc func tapLoginButton() {
    UIApplication.shared.open(API.shared.oAuthURL, options: [:], completionHandler: nil)
  }
}
