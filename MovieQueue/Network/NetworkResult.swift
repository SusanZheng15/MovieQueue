//
//  NetworkResult.swift
//  MovieQueue
//
//  Created by Susan Zheng on 4/11/19.
//  Copyright © 2019 Susan Zheng. All rights reserved.
//

import Foundation

public enum ApiResult<T> {
    case success(T)
    case unAuthenticated
    case badUrl
    case couldNotParseJSONData
    case noInternetConnection
    case serverError
    case notFound
    case clientError
    case other(rawError: Error)
}
