//
//  Coordinator.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/22/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navController: UINavigationController { get set }
    func start()
}
