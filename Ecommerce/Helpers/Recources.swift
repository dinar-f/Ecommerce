//
//  Recources.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import UIKit

enum R {
    enum Colors {
        static var primary = UIColor(hexString: "#437BFE")
        static var secondary = UIColor(hexString: "#8F959E")
        
        static var brown = UIColor(hexString: "#704f38")
        static var gray = UIColor(hexString: "#e7e7e7")
        
//        static var inactive = UIColor(hexString: "#929DA5")
//        
//        static var background = UIColor(hexString: "#F8F9F9")
//        static var searator = UIColor(hexString: "#E8ECEF")
//        static var secondary = UIColor(hexString: "#F0F3FF")
//        
//        static var titleGray = UIColor(hexString: "#545C77")
        
    }
    
    enum Images {
        enum TabBar {
            static var home = UIImage(named: "home")
            static var cart = UIImage(named: "cart")
        }
        
        enum navBar {
            static var userAvatar = UIImage(named: "user_avatar")
            static var cart = UIImage(named: "shopping_cart")
            static var search = UIImage(named: "search")
        }
        
        enum Common {
            
        }
    }
    
    enum Fonts {
        static func montserratRegular(with size:CGFloat) -> UIFont {
            return UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
