//
//  DetailViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/*
 TODO:
 
    - move all swipe/button functions from view to here
    - create button functions to start timer here
    - create timer view and view model
    - create time stamp entity, connect with goals entity one to many relation
    - create update function in Core Data, call it when we swipe timer view down
    - create function to create text string to store in time stamp table view
 
 */

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var goal: NSManagedObject?
    let detailView = DetailView(frame: UIScreen.main.bounds)
    var timeStampsTableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        guard let unwrappedGoal = goal else {
            print("ERROR: goal not passed to DetailViewController correctly")
            return
        }
        let gesture = UISwipeGestureRecognizer()
        let detailViewModel = DetailViewModel(goal: unwrappedGoal)
        let percentage = detailViewModel.calcPercent()
        navigationItem.title = unwrappedGoal.value(forKey: "title") as? String
        view.addSubview(detailView)
        setupTableView()
        setupGesture(gesture: gesture)
        detailView.timeStampView.addGestureRecognizer(gesture)
        detailView.animateBar(percentage: percentage)
        detailView.timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
       

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
    
    func setupGesture(gesture: UISwipeGestureRecognizer) {
        gesture.numberOfTouchesRequired = 1
        gesture.direction = .up
        gesture.addTarget(self, action: #selector(viewSwiped(gesture:)))
    }
    
    @objc func viewSwiped(gesture: UISwipeGestureRecognizer) {
        print("Time stamps header swiped")
        detailView.scrollUpAndDown(gesture: gesture)
    }
    
    @objc func timeButtonTapped() {
        print("timer tapped")
        detailView.blurScreen()
        let timerVC = TimerViewController()
        timerVC.modalPresentationStyle = .overFullScreen
        present(timerVC, animated: true, completion: nil)
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
