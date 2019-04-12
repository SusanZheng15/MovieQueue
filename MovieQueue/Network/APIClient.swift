//
//  APIClient.swift
//  MovieQueue
//
//  Created by Susan Zheng on 4/11/19.
//  Copyright © 2019 Susan Zheng. All rights reserved.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func getResult(page: Int, completion: @escaping (ApiResult<[String : Any]>) -> Void){
        NetworkManager.shared.getRequest(urlString: "https://api.themoviedb.org/3/movie/upcoming?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed", completion: completion)
    }
}
