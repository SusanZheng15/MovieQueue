//
//  AppUtility.swift
//  MovieQueue
//
//  Created by Susan Zheng on 4/11/19.
//  Copyright © 2019 Susan Zheng. All rights reserved.
//

import Foundation
import UIKit

class AppUtility {
    static let shared = AppUtility()
    
    private init() {}
    
    func getCurrentViewController() -> UIViewController? {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController{
            var currentController: UIViewController! = rootController
            while(currentController.presentedViewController != nil){
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    func showAlert(_ title: String? = "", message: String? = "", vc: UIViewController? = nil, actionTitle: String) {
        var vc: UIViewController? = vc
        if vc == nil{
            vc = getCurrentViewController()
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func handleAPIResultError<T>(_ result: ApiResult<T>){
        switch result {
        case .badUrl:
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.generalAPIError, actionTitle: Constants.Strings.dismiss)
        case .clientError:
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.generalAPIError, actionTitle: Constants.Strings.dismiss)
        case .noInternetConnection:
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.noInternetConnection, actionTitle: Constants.Strings.dismiss)
        case .couldNotParseJSONData:
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.generalAPIError, actionTitle: Constants.Strings.dismiss)
        case .serverError:
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.serverError, actionTitle: Constants.Strings.dismiss)
        case .notFound:
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.generalAPIError, actionTitle: Constants.Strings.dismiss)
        case .other(rawError: _):
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.serverError, actionTitle: Constants.Strings.dismiss)
        default:
            self.showAlert(Constants.Strings.generalErrorTitle, message: Constants.Strings.generalAPIError, actionTitle: Constants.Strings.dismiss)
        }
    }
}
