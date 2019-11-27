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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Goals"
        navigationItem.hidesBackButton = true
        updateCollectionView()
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        viewModel.goalsArr = viewModel.populateGoalList()
        setupCollectionView()
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
    
    private func setupCollectionView() {
        goalCollectionView.register(GoalCollectionCell.self, forCellWithReuseIdentifier: GoalCollectionCell.identifier)
        goalCollectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        goalCollectionView.dataSource = self
        goalCollectionView.delegate = self
        view.addSubview(goalCollectionView)
        collectionConstraints()
    }
    
    private func buttonConstraints() {
        newGoalButton.translatesAutoresizingMaskIntoConstraints = false
        newGoalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        newGoalButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGoalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
    }
    
    private func collectionConstraints() {
        goalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        goalCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        goalCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        goalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        goalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension HomeViewController {
    
    @objc func optionsButtonTapped(sender: UIButton) {
        let index = sender.tag
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.goalCollectionView.performBatchUpdates({
                guard let resultList = self.viewModel.deleteGoal(index: sender.tag, goalList: self.viewModel.goalsArr) else { return }
                self.viewModel.goalsArr = resultList
                self.goalCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
            }, completion: { _ in
                self.updateCollectionView()
            })
        })
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

