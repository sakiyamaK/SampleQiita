//
//  QiitaAccessTokenModel.swift
//  SampleQiita
//
//  Created by sakiyamaK on 2020/11/07.
//

import Foundation

struct QiitaAccessTokenModel: Codable {
  let clientId: String
  let scopes: [String]
  let token: String
}
