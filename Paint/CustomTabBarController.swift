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
        let paintVc = PaintViewController(nibName: "PaintViewController", bundle: nil)
        configControllerItem(paintVc, title: "创作", imageName: "paint_icon_nomal", selectImageName: "paint_icon_focus")
        let rankingVc = RankingViewController(nibName:"RankingViewController" , bundle: nil)
        configControllerItem(rankingVc, title: "排行", imageName: "ranking_icon_nomal", selectImageName: "ranking_icon_focus")
        let userVc = UserViewController(nibName: "UserViewController", bundle: nil)
        configControllerItem(userVc, title: "我的", imageName: "user_icon_nomal", selectImageName: "user_icon_focus")
    }
    
    private func configControllerItem(_ vc: UIViewController, title: String, imageName: String, selectImageName: String) {
        let navVc = UINavigationController(rootViewController: vc)
        navVc.tabBarItem = UITabBarItem(title: title, image: UIImage(named:imageName)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:selectImageName)?.withRenderingMode(.alwaysOriginal))
        self.addChildViewController(navVc)
    }

}
