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
    let detailView = DetailView(frame: UIScreen.main.bounds)
    var timeStampsTableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrappedGoal = goal else {
            
            print("ERROR: goal not passed to DetailViewController correctly")
            return
        }
        
        let detailViewModel = DetailViewModel(goal: unwrappedGoal)
        view.addSubview(detailView)
        setupTableView()
        navigationItem.title = unwrappedGoal.value(forKey: "title") as? String
        
        let percentage = detailViewModel.calcPercent()
        detailView.animateBar(percentage: percentage)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(detailView.timeStampView.frame)
    }
    
    func setupTableView() {
        
        let tableViewFrame = CGRect(x: 0, y: detailView.timeStampView.frame.height * 0.08, width: detailView.timeStampView.frame.width, height: detailView.timeStampView.frame.height)
        timeStampsTableView.frame = tableViewFrame
        timeStampsTableView.separatorColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        timeStampsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        timeStampsTableView.delegate = self
        timeStampsTableView.dataSource = self
        detailView.timeStampView.addSubview(timeStampsTableView)
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
