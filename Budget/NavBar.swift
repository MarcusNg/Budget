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
    
    // Custom Navbar TEMP (put into a static class)
    static func customizeNavBar(navController: UINavigationController?) {
        navController?.navigationBar.tintColor = UIColor(colorLiteralRed: RGBFloat(x: 255), green: RGBFloat(x: 255), blue: RGBFloat(x: 255), alpha: 1) // Bar Item Tint
        navController?.navigationBar.barTintColor = UIColor(colorLiteralRed: RGBFloat(x: 51), green: RGBFloat(x: 204), blue: RGBFloat(x: 51), alpha: 1) // NavBar
        navController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Title
    }
    
}
