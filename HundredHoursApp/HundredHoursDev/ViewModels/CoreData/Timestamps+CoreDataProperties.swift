//
//  Timestamps+CoreDataProperties.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 3/31/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//
//

import Foundation
import CoreData


extension Timestamps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timestamps> {
        return NSFetchRequest<Timestamps>(entityName: "Timestamps")
    }

    @NSManaged public var day: Date?
    @NSManaged public var session: Int64
    @NSManaged public var goal: Goal?

}
