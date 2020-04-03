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
    private let viewModel = HomeViewModel()
    private let flowLayout = UICollectionViewFlowLayout()
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
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }
    
    private func setupView() {
        setupCollectionView()
        viewModel.goalsArr = viewModel.populateGoalList()
        newGoalButton = createNewGoalButton()
        view.addSubview(newGoalButton)
        buttonConstraints()
    }
    
    private func setupCollectionView() {
       goalCollectionView.register(GoalCollectionCell.self, forCellWithReuseIdentifier: GoalCollectionCell.identifier)
       goalCollectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       goalCollectionView.dataSource = self
       goalCollectionView.delegate = self
       view.addSubview(goalCollectionView)
       collectionConstraints()
    }
    
    private func updateCollectionView() {
        viewModel.goalsArr = viewModel.populateGoalList()
        goalCollectionView.reloadData()
        checkEmptyState()
    }
    
    private func checkEmptyState() {
        if viewModel.goalsArr.isEmpty {
            let noGoalsView = NoGoalsHomeView(frame: goalCollectionView.frame)
            goalCollectionView.backgroundView = noGoalsView
        } else {
            goalCollectionView.backgroundView = nil
        }
    }
    
    private func buttonConstraints() {
        newGoalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newGoalButton.topAnchor.constraint(equalTo: goalCollectionView.safeAreaLayoutGuide.bottomAnchor),
            newGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGoalButton.widthAnchor.constraint(equalTo: goalCollectionView.widthAnchor, multiplier: 0.4),
            newGoalButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func collectionConstraints() {
        goalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            goalCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            goalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            goalCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            goalCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
    }
}

extension HomeViewController {
    
    @objc func optionsButtonTapped(sender: UIButton) {
        let index = sender.tag
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.goalCollectionView.performBatchUpdates({
                if let id = self.viewModel.goalsArr[index].notificationID {
                    self.viewModel.removeNotification(self.notificationObj, id)
                }
                guard let resultList = self.viewModel.deleteGoal(index: index, goalList: self.viewModel.goalsArr) else { return }
                self.viewModel.goalsArr = resultList
                self.goalCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
            }, completion: { _ in
                self.updateCollectionView()
            })
        })
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { action in
            let curGoal = self.viewModel.goalsArr[index]
            self.coordinator?.editGoal(goal: curGoal)
        })
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func addTapped() {
        coordinator?.createNewGoal()
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.goalsArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellString = viewModel.getCellString(indexPath: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCollectionCell.identifier, for: indexPath) as! GoalCollectionCell
        cell.setCellLabelFont(text: cellString)
        cell.cellLabel.text = cellString
        cell.cellTextView.text = viewModel.goalsArr[indexPath.row].goalDescription
        cell.optionsButton.tag = indexPath.row
        cell.optionsButton.addTarget(self, action: #selector(optionsButtonTapped), for: .touchUpInside)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goalToPass = viewModel.goalsArr[indexPath.row]
        coordinator?.goToDetailScreen(goal: goalToPass)
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
        let height = viewModel.resizeCell(indexPath: indexPath, view: collectionView)
        return CGSize(width: collectionView.bounds.width, height: 60 + height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

