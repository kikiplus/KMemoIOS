//
//  UIColor.swift
//  kbucket
//
//  Created by 김미혜 on 2018. 8. 29..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init?(hexRGBA: String?) {
        guard let rgba = hexRGBA, let val = Int(rgba.replacingOccurrences(of: "#", with: ""), radix: 16) else {
            return nil
        }
        self.init(red: CGFloat((val >> 24) & 0xff) / 255.0, green: CGFloat((val >> 16) & 0xff) / 255.0, blue: CGFloat((val >> 8) & 0xff) / 255.0, alpha: CGFloat(val & 0xff) / 255.0)
    }
    convenience init?(hexRGB: String?) {
        guard let rgb = hexRGB else {
            return nil
        }
        self.init(hexRGBA: rgb + "ff") // Add alpha = 1.0
    }
  
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rr = Int(Float(r * 0xFF)) > 255 ? 255 : Int(Float(r * 0xFF)) < 0 ? 0 : Int(Float(r * 0xFF))
        let gg = Int(Float(g * 0xFF)) > 255 ? 255 : Int(Float(g * 0xFF)) < 0 ? 0 : Int(Float(g * 0xFF))
        let bb = Int(Float(b * 0xFF)) > 255 ? 255 : Int(Float(b * 0xFF)) < 0 ? 0 : Int(Float(b * 0xFF))
        let aa = Int(Float(a * 0xFF)) > 255 ? 255 : Int(Float(a * 0xFF)) < 0 ? 0 : Int(Float(a * 0xFF))
        
        let color = String(
            format: "#%02X%02X%02X%02X", aa, rr, gg, bb
        )
        return color
    }
}
