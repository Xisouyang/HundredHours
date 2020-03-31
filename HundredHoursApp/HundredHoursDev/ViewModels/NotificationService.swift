//
//  NotificationService.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 3/31/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class NotificationService {
    func requestNotifications(completion: @escaping (_ success: Bool) -> ()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge], completionHandler: { granted, error in
            if let error = error {
                NSLog(error.localizedDescription)
                return
            }
            if (granted == true || granted == false) && error == nil {
                completion(true)
            }
        })
    }
}
