//
//  QiitaItemModel.swift
//  SampleQiita
//
//  Created by sakiyamaK on 2020/11/07.
//

import Foundation

struct QiitaItemModel: Codable {
  var urlStr: String
  var title: String

  enum CodingKeys: String, CodingKey {
    case urlStr = "url"
    case title = "title"
  }
  var url: URL? { URL.init(string: urlStr) }
}
