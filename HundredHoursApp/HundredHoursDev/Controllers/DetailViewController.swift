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
    var timeStampsTableView = UITableView(frame: .zero)

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
        
        let percentage = detailViewModel.calcPercent()
        detailView.animateBar(percentage: percentage)
    }
    
    func setupTableView() {
        timeStampsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        timeStampsTableView.delegate = self
        timeStampsTableView.dataSource = self
    }
}

extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        return cell
    }
}
