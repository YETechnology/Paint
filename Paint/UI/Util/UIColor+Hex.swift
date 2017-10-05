//
//  UIColor+Hex.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/3.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

extension UIColor {
    class func color(with hex: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat((hex & 0xFF0000) >> 16)/255.0, green: CGFloat((hex & 0xFF00) >> 8)/255.0, blue: CGFloat(hex & 0xFF)/255.0, alpha: alpha)
    }
    
    class func color(with hex: Int) -> UIColor {
        //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
        var alpha = CGFloat((hex & 0xFF000000) >> 16)/255.0
        if alpha <= 0.0 || alpha > 1.0 {
            alpha = 1.0
        }
        return UIColor.color(with: hex, alpha: alpha)
    }
    
    public func hex() ->Int? {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        if self.getRed(&r, green: &g, blue: &b, alpha: &alpha) {
            let iRed = Int(r * 255.0)
            let iGreen = Int(g * 255.0)
            let iBlue = Int(b * 255.0)
            let iAlpha = Int(alpha * 255.0)
            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return rgb
        } else {
            return nil
        }
    }
}
