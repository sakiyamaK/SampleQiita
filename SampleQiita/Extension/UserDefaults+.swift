//
//  UserDefaults+.swift
//  SampleQiita
//
//  Created by sakiyamaK on 2020/11/07.
//

import Foundation

extension UserDefaults {
  private var qiitaAccessTokenKey: String { "qiitaAccessTokenKey" }
  var qiitaAccessToken: String {
    get {
      self.string(forKey: qiitaAccessTokenKey) ?? ""
    }
    set {
      self.setValue(newValue, forKey: qiitaAccessTokenKey)
    }
  }
}
