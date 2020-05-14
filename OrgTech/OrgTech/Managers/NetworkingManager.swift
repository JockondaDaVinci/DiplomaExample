//
//  NetworkingManager.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

protocol JSONEncodable: Codable {
  func toJSONData() -> Data?
}

final class NetworkingManager {
  private var session: URLSession
  static let shared = NetworkingManager()
  
  init() {
    let configuration = URLSessionConfiguration.default
    session = URLSession(configuration: configuration)
  }
  
  func startGetTask<ObjectType: Codable>(forURL url: String, object: ObjectType.Type, completion: @escaping (ObjectType?, Error?) -> Void) {
    guard let url = URL(string: url) else {
      completion(nil, NetworkError.invalidURL)
      return
    }
    
    session.dataTask(with: url) { data, response, error in
      if error != nil || data == nil {
        dispatchMain {
          completion(nil, error)
        }
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let object = try decoder.decode(ObjectType.self, from: data!)
        dispatchMain {
          completion(object, nil)
        }
      } catch {
        dispatchMain {
          completion(nil, error)
        }
      }
    }.resume()
  }
  
  func startPostTask<PostObjectType, ResponseObjectType>(forURL url: String, postObject: PostObjectType, responseObject: ResponseObjectType.Type, completion: @escaping (ResponseObjectType?, Error?) -> Void) where PostObjectType: JSONEncodable, ResponseObjectType: Codable {
    guard let url = URL(string: url) else {
      completion(nil, NetworkError.invalidURL)
      return
    }
    
    guard let httpBody = postObject.toJSONData() else {
      completion(nil, NetworkError.invalidBody)
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = httpBody
    
    session.dataTask(with: request) { data, response, error in
      if error != nil || data == nil {
        dispatchMain {
          completion(nil, error)
        }
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let object = try decoder.decode(ResponseObjectType.self, from: data!)
        dispatchMain {
          completion(object, nil)
        }
      } catch {
        dispatchMain {
          completion(nil, error)
        }
      }
    }.resume()
  }
  
  func downloadImage(forURL urlStr: String, completion: @escaping (Data?, Error?) -> ()) {
    guard let url = URL(string: [API.apiBase, urlStr].joined()) else { return }
    session.dataTask(with: url) { data, response, error in
      if error != nil || data == nil {
        completion(nil, error)
        return
      }
      dispatchMain {
        CacheManager.shared.cacheImage(data, byKey: urlStr)
        completion(data, error)
      }
    }.resume()
  }
}

// MARK: - Push to main asyncronyously
fileprivate func dispatchMain(completion: @escaping () -> Void) {
  DispatchQueue.main.async {
    completion()
  }
}

// MARK: - Custom networking errors
enum NetworkError: Error {
  case invalidURL
  case dataIsEmpty
  case invalidBody
}
