//
//  ViewController.swift
//  Paint
//
//  Created by yawei zhan on 2017/9/30.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        YENetworkEngine.engine.request("http://YEtest.com/get", handleType: PagedBreweries.self) { (response) in
            if response.retCode == .success {
                let page: PagedBreweries = response.responseObject!
                print(page)
            } else {
                print("请求错误")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

