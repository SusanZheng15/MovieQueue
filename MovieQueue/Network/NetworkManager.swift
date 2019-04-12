//
//  NetworkManager.swift
//  MovieQueue
//
//  Created by Susan Zheng on 4/11/19.
//  Copyright © 2019 Susan Zheng. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getRequest<T>(urlString: String, completion: @escaping (ApiResult<T>) -> Void) {
        guard let url = URL(string: urlString) else{
            completion(.badUrl)
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async() {
                if let error = error{
                    if let response = response as? HTTPURLResponse{
                        switch response.statusCode{
                        case 200...299: break
                        case 404: completion(.notFound)
                        case 400...499: completion(.clientError)
                        case 500...599: completion(.serverError)
                        default:
                            completion(.other(rawError: error))
                        }
                    } else {
                        completion(.other(rawError: error))
                    }
                } else{
                    if let response = response as? HTTPURLResponse{
                        switch response.statusCode{
                        case 200...299:
                            do {
                                if let data = data{
                                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! T
                                    completion(.success(jsonResult))
                                }else{
                                    completion(.couldNotParseJSONData)
                                }
                                
                            } catch {
                                completion(.couldNotParseJSONData)
                            }
                        case 404: completion(.notFound)
                        case 400...499: completion(.clientError)
                        case 500...599: completion(.serverError)
                        default:
                            print("http error occurred, could not manage")
                        }
                    }
                }
            }
        }.resume()
    }
}
