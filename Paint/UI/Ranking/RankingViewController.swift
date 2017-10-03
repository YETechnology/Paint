//
//  RankingViewController.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/1.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showLoadingView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.showFailedView {
            self.view.showEmptyView()
            print("retry button clicked")
        }
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
