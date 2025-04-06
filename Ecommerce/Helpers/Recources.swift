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
        
        static var white = UIColor(hexString: "#FFFFFF")
        static var brown = UIColor(hexString: "#704f38")
        static var gray = UIColor(hexString: "#e7e7e7")
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
            static var share = UIImage(named: "share")
            static var checkmark = UIImage(named: "сheckmark")
            
            static var noImageStub = UIImage(named: "no_image_stub")
            static var notFound = UIImage(named: "not_found")
        }
    }
    
    enum Fonts {
        static func montserratRegular(with size:CGFloat) -> UIFont {
            return UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}
