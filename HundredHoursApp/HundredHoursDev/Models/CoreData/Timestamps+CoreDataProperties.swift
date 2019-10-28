//
//  Timestamps+CoreDataProperties.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/4/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Timestamps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timestamps> {
        return NSFetchRequest<Timestamps>(entityName: "Timestamps")
    }

    @NSManaged public var session: Int64
    @NSManaged public var day: NSDate?
    @NSManaged public var goal: Goal?

}