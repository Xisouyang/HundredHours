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
    
    static let onboardTitleFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 30)
        return font ?? UIFont.systemFont(ofSize: 30)
    }()
    
    static let onboardDescriptionFont: UIFont = {
        let font = UIFont(name: "Avenir", size: 18)
        return font ?? UIFont.systemFont(ofSize: 18)
    }()
    
    static let goalTitleFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 18)
        return font ?? UIFont.systemFont(ofSize: 18)
    }()
    
    static let smallerTitleFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 14)
        return font ?? UIFont.systemFont(ofSize: 14)
    }()
    
    static let goalDescriptionFont: UIFont = {
        let font = UIFont(name: "Avenir", size: 15)
        return font ?? UIFont.systemFont(ofSize: 15)
    }()
    
    static let newGoalNameFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 20)
        return font ?? UIFont.systemFont(ofSize: 20)
    }()
    
    static let newGoalFieldFont: UIFont = {
        let font = UIFont(name: "Avenir-Medium", size: 18)
        return font ?? UIFont.systemFont(ofSize: 18)
    }()
    
    static let emptyStateFont: UIFont = {
        let font = UIFont(name: "Avenir-Heavy", size: 20)
        return font ?? UIFont.systemFont(ofSize: 20)
    }()
}
