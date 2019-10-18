//
//  DetailViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

/* Pan-gesture recognizer instead of swipe */

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var goal: Goal?
    let detailViewModel = DetailViewModel()
    var timerViewModel = TimerViewModel()
    let detailView = DetailView(frame: UIScreen.main.bounds)
    var timeStampsTableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(resetScreen), name: Notification.Name("timerVC dismissed"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let timeStampHeaderHeight = detailView.timeStampTitle.safeAreaLayoutGuide.layoutFrame.height
        let tableViewFrame = CGRect(x: 0, y: detailView.timeStampView.frame.height * 0.08, width: detailView.timeStampView.frame.width, height: detailView.safeAreaLayoutGuide.layoutFrame.height - timeStampHeaderHeight)
        timeStampsTableView.frame = tableViewFrame
    }
    
    private func setupView() {
        guard let unwrappedGoal = goal else {
            print("ERROR: goal not passed to DetailViewController correctly")
            return
        }
        let gesture = UISwipeGestureRecognizer()
        let percentage = detailViewModel.calcPercent(goal: unwrappedGoal)
        navigationItem.title = unwrappedGoal.value(forKey: "title") as? String
        view.addSubview(detailView)
        setupTableView()
        detailViewModel.populateStampsArr(goal: unwrappedGoal)
        setupGesture(gesture: gesture)
        detailView.timeStampView.addGestureRecognizer(gesture)
        detailView.animateBar(percentage: percentage)
        detailView.timeButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        timeStampsTableView.separatorColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        timeStampsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        timeStampsTableView.dataSource = self
        detailView.timeStampView.addSubview(timeStampsTableView)
    }
    
    private func setupGesture(gesture: UISwipeGestureRecognizer) {
        gesture.numberOfTouchesRequired = 1
        gesture.direction = .up
        gesture.addTarget(self, action: #selector(viewSwiped(gesture:)))
    }
    
    @objc func viewSwiped(gesture: UISwipeGestureRecognizer) {
        print("Time stamps header swiped")
        detailView.scrollUpAndDown(gesture: gesture)
    }
    
    //TODO: find if we can also blur the navbar
    @objc func timeButtonTapped() {
        print("timer tapped")
        detailView.addBlur()
        let timerVC = TimerViewController()
        timerVC.modalPresentationStyle = .overFullScreen
        timerViewModel = timerVC.timerViewModel
        present(timerVC, animated: true, completion: nil)
    }
    
    @objc func resetScreen() {
        guard let unwrappedGoal = goal else { return }
        detailView.removeBlur()
        let timeToSave = timerViewModel.getSeconds()
        detailViewModel.saveTimeStamp(time: timeToSave, goal: unwrappedGoal)
        detailViewModel.updateCurrentTime(goal: unwrappedGoal, seconds: timeToSave)
        let newPercent = detailViewModel.calcPercent(goal: unwrappedGoal)
        detailView.animateBar(percentage: newPercent)
        let session = timerViewModel.getTimeLabel()
        detailViewModel.timeStampsArr.insert(session, at: 0)
        timeStampsTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("timerVC dismissed"), object: nil)
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.timeStampsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        cell.textLabel?.text = String(detailViewModel.timeStampsArr[indexPath.row])
        return cell
    }
}
