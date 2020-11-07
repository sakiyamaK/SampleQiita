//
//  API.swift
//  SampleQiita
//
//  Created by sakiyamaK on 2020/11/07.
//

import Foundation
import Alamofire

enum APIError: Error {
  case postAccessToken
  case getItems
}

final class API {
  static let shared = API()
  private init() {}

  private let host = "https://qiita.com/api/v2"
  private let clientID = "<https://qiita.com/settings/applications で設定した値を代入>"
  private let clientSecret = "<https://qiita.com/settings/applications で設定した値を代入>"
  let qiitState = "bb17785d811bb1913ef54b0a7657de780defaa2d"

  static let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()

  enum  URLParameterName: String {
    case clientID = "client_id"
    case clientSecret = "client_secret"
    case scope = "scope"
    case state = "state"
    case code = "code"
  }

  var oAuthURL: URL {
    let endPoint = "/oauth/authorize"
    return URL(string: host + endPoint + "?" +
                "\(URLParameterName.clientID.rawValue)=\(clientID)" + "&" +
                "\(URLParameterName.scope.rawValue)=read_qiita+write_qiita" + "&" +
                "\(URLParameterName.state.rawValue)=\(qiitState)")!
  }

  func postAccessToken(code: String, completion: ((QiitaAccessTokenModel?, Error?) -> Void)? = nil) {
    let endPoint = "/access_tokens"
    guard let url = URL(string: host + endPoint + "?" +
                          "\(URLParameterName.clientID.rawValue)=\(clientID)" + "&" +
                          "\(URLParameterName.clientSecret.rawValue)=\(clientSecret)" + "&" +
                          "\(URLParameterName.code)=\(code)") else {
      completion?(nil, APIError.postAccessToken)
      return
    }

    AF.request(url, method: .post).responseJSON { (response) in
      do {
        guard
          let _data = response.data else {
          completion?(nil, APIError.postAccessToken)
          return
        }
        let accessToken = try API.jsonDecoder.decode(QiitaAccessTokenModel.self, from: _data)
        completion?(accessToken, nil)
      } catch let error {
        completion?(nil, error)
      }
    }
  }

  func getItems(completion: (([QiitaItemModel]?, Error?) -> Void)? = nil) {
    let endPoint = "/authenticated_user/items"
    guard let url = URL(string: host + endPoint),
          UserDefaults.standard.qiitaAccessToken.count > 0 else {
      completion?(nil, APIError.getItems)
      return
    }
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(UserDefaults.standard.qiitaAccessToken)"
    ]
    let parameters = [
      "page": 1,
      "per_page": 20
    ]

    AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
      do {
        guard
          let _data = response.data else {
          completion?(nil, APIError.getItems)
          return
        }
        let items = try API.jsonDecoder.decode([QiitaItemModel].self, from: _data)
        completion?(items, nil)
      } catch let error {
        completion?(nil, error)
      }
    }  }
}
