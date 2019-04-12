//
//  ViewController.swift
//  MovieQueue
//
//  Created by Susan Zheng on 4/11/19.
//  Copyright © 2019 Susan Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .blue
        APIClient.shared.getResult(page: 1) { (result) in
            DispatchQueue.main.async(execute: {
                switch result {
                case .success(let d):
                    print(d)
                    break
                default:
                    AppUtility.shared.handleAPIResultError(result)
                }
            })
        }
    }


}

