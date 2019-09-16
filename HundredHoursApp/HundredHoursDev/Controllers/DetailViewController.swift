//
//  DetailViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var goal: NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrappedGoal = goal else {
            
            print("ERROR: goal not passed to DetailViewController correctly")
            return
        }
        
        let detailViewModel = DetailViewModel(goal: unwrappedGoal)
        let detailView = DetailView(frame: view.frame)
        view.addSubview(detailView)
        navigationItem.title = unwrappedGoal.value(forKey: "title") as? String
        
    }
}
