//
//  NavBar.swift
//  Budget
//
//  Created by Marcus Ng on 5/7/17.
//  Copyright © 2017 Marcus Ng. All rights reserved.
//

import Foundation

class NavBar {
    
    // Convert int to float
    static func RGBFloat(x: Int) -> Float {
        return Float(x) / 255
    }
    
    // Return UIColor
    static func RGB(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(colorLiteralRed: RGBFloat(x: r), green: RGBFloat(x: g), blue: RGBFloat(x: b), alpha: 1)
    }
    
    // Custom Navbar
    static func customizeNavBar(navController: UINavigationController?) {
        navController?.navigationBar.tintColor = RGB(r: 255, g: 255, b: 255) // Bar Item Tint
        navController?.navigationBar.barTintColor = RGB(r: 61, g: 216, b: 76) // Navbar color
        navController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Title
    }
    
}
