//
//  ViewController.swift
//  100HoursDev
//
//  Created by Stephen Ouyang on 9/2/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    private let homeViewModel = HomeViewModel()
    private var timerViewModel = TimerViewModel()
    private let flowLayout = UICollectionViewFlowLayout()
    private let containerView = UIView()
    private var goalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var newGoalButton = UIButton()
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
        view.backgroundColor = #colorLiteral(red: 0.6601266861, green: 0, blue: 0.9897789359, alpha: 1)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Goals To Crush"
        navigationItem.hidesBackButton = true
        notificationObj.configSettings()
        updateCollectionView()
    }
    
    private func createNewGoalButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.668626368, green: 0, blue: 1, alpha: 1)
        button.setTitle("New Goal", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }
    
    private func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(timerViewTappedToQuit), name: Notification.Name("timerVC dismissed"), object: nil)
        setupCollectionView()
        homeViewModel.goalsArr = homeViewModel.populateGoalList()
        newGoalButton = createNewGoalButton()
        view.addSubview(newGoalButton)
        buttonConstraints()
    }
    
    private func setupCollectionView() {
        view.addSubview(containerView)
        containerViewConstraints()
       goalCollectionView.register(GoalCollectionCell.self, forCellWithReuseIdentifier: GoalCollectionCell.identifier)
       goalCollectionView.backgroundColor = #colorLiteral(red: 0.6599579453, green: 0.003643606091, blue: 0.9897441268, alpha: 1)
       goalCollectionView.dataSource = self
       goalCollectionView.delegate = self
       view.addSubview(goalCollectionView)
       collectionConstraints()
    }
    
    private func updateCollectionView() {
        homeViewModel.goalsArr = homeViewModel.populateGoalList()
        goalCollectionView.reloadData()
        checkEmptyState()
    }
    
    private func checkEmptyState() {
        if homeViewModel.goalsArr.isEmpty {
            let noGoalsView = NoGoalsHomeView(frame: goalCollectionView.frame)
            goalCollectionView.backgroundView = noGoalsView
        } else {
            goalCollectionView.backgroundView = nil
        }
    }
    
    func startTimer(with goal: Goal) {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        navigationController?.navigationBar.isUserInteractionEnabled = false
        let timerVC = TimerViewController()
        timerViewModel = timerVC.timerViewModel
        timerViewModel.goal = goal
        timerVC.modalPresentationStyle = .overFullScreen
        present(timerVC, animated: true, completion: nil)
    }
    
    func resetHomeView() {
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        guard let goal = timerViewModel.getGoal() else { return }
        let seconds = timerViewModel.getSeconds()
        homeViewModel.updateGoalProgress(goal: goal, seconds: seconds)
        goalCollectionView.reloadData()
    }
    
    @objc private func timerViewTappedToQuit() {
        resetHomeView()
    }
    
    private func buttonConstraints() {
        newGoalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newGoalButton.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            newGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGoalButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            newGoalButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func containerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65)
        ])
    }
    
    private func collectionConstraints() {
        goalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalCollectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            goalCollectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            goalCollectionView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            goalCollectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
    }
}

extension HomeViewController {
    
    @objc func addTapped() {
        coordinator?.createNewGoal()
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.goalsArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let goal = homeViewModel.goalsArr[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCollectionCell.identifier, for: indexPath) as! GoalCollectionCell
        homeViewModel.configure(cell, goal)
        homeViewModel.animateBar(collectionView, cell, indexPath, notificationObj)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goal = homeViewModel.goalsArr[indexPath.item]
        startTimer(with: goal)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

