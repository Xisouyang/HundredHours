//
//  DetailViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/13/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.

//TODO:  pass time to save into animate bar function to animate text percentage instead of 'loading'

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    weak var goal: Goal?
    private let detailViewModel = DetailViewModel()
    private var timerViewModel = TimerViewModel()
    private let detailView = GoalDetailView(frame: UIScreen.main.bounds)
    private var timeStampsTableView = UITableView(frame: .zero)
    private let notificationObj: NotificationService
    
    init(_ notificationObj: NotificationService) {
        self.notificationObj = notificationObj
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
         NotificationCenter.default.addObserver(self, selector: #selector(resetScreen), name: Notification.Name("timerVC dismissed"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configTimeStampView()
    }
    
    private func configTimeStampView() {
        let tableViewFrame = CGRect(x: 0, y: detailView.timeStampView.frame.height * 0.08, width: detailView.timeStampView.frame.width, height: detailView.safeAreaLayoutGuide.layoutFrame.height * 0.85)
        timeStampsTableView.frame = tableViewFrame
    }
    
    private func setupView() {
        guard let unwrappedGoal = goal else {
            print("ERROR: goal not passed to DetailViewController correctly")
            return
        }
        let gesture = UIPanGestureRecognizer()
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
    
    private func setupGesture(gesture: UIPanGestureRecognizer) {
        gesture.addTarget(self, action: #selector(viewSwiped(gesture:)))
    }
    
    @objc func viewSwiped(gesture: UIPanGestureRecognizer) {
        detailView.viewDragged(gesture: gesture)
    }
    
    //TODO: find if we can also blur the navbar
    @objc func timeButtonTapped() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        detailView.addBlur()
        let timerVC = TimerViewController()
        timerVC.modalPresentationStyle = .overFullScreen
        timerViewModel = timerVC.timerViewModel
        present(timerVC, animated: true, completion: nil)
    }
    
    @objc func resetScreen() {
        guard let unwrappedGoal = goal else { return }
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        detailView.removeBlur()
        updateData(goal: unwrappedGoal)
    }
    
    private func updateData(goal: Goal) {
        let timeToSave = timerViewModel.getSeconds()
        detailViewModel.saveTimeStamp(time: timeToSave, goal: goal)
        detailViewModel.updateCurrentTime(goal: goal, seconds: timeToSave)
        let newPercent = detailViewModel.calcPercent(goal: goal)
        if newPercent == 1 {
            if let id = goal.notificationID {
                notificationObj.removeNotificationRequest(id)
            }
        }
        detailView.animateBar(percentage: newPercent)
        let session = timerViewModel.getTimeLabel()
        detailViewModel.timeStampsArr.insert(session, at: 0)
        timeStampsTableView.reloadData()
    }
    
    @objc func editTapped() {
        guard let unwrappedGoal = goal else { return }
        coordinator?.editGoal(goal: unwrappedGoal)
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
        cell.selectionStyle = .none
        cell.textLabel?.text = String(detailViewModel.timeStampsArr[indexPath.row])
        return cell
    }
}
