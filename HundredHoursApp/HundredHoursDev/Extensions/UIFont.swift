//
//  UIFont.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static let titleFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 30)
        return font ?? UIFont.systemFont(ofSize: 30)
    }()
    
    static let descriptionFont: UIFont = {
        let font = UIFont(name: "Avenir", size: 18)
        return font ?? UIFont.systemFont(ofSize: 18)
    }()
}
