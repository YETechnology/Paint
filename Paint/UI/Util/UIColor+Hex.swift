//
//  UIColor+Hex.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/3.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

extension UIColor {
    class func color(with hex: Int32, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16)/255.0, green: CGFloat((hex & 0xFF00) >> 8)/255.0, blue: CGFloat(hex & 0xFF)/255.0, alpha: alpha)
    }
    
    class func color(with hex: Int32) -> UIColor {
        return UIColor.color(with: hex, alpha: 1.0)
    }
}
