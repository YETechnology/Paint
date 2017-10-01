//
//  CustomTabBarController.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/1.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configItemViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func configItemViewController() {
        configControllerItem(name: "PaintViewController", title: "创作", imageName: "tab_recent_nor")
        configControllerItem(name: "RankingViewController", title: "排行", imageName: "tab_qworld_nor")
        configControllerItem(name: "UserViewController", title: "我的", imageName: "tab_buddy_nor")
    }
    
    private func configControllerItem(name: String, title: String, imageName: String) {
        let vc = UIViewController(nibName: name, bundle: nil)
        let navVc = UINavigationController(rootViewController: vc)
        navVc.tabBarItem.title = title
        navVc.tabBarItem.image = UIImage(named:imageName)
        self.addChildViewController(navVc)
    }

}
