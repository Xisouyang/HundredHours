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
    private var goalTableView = UITableView()
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
        updateTableView()
    }
    
    private func setupView() {
        newGoalButton = createNewGoalBtn()
        view.addSubview(newGoalButton)
        buttonConstraints()
        setTableView()
        viewModel.goalsArr = viewModel.populateGoalList()
    }
    
    private func updateTableView() {
        viewModel.goalsArr = viewModel.populateGoalList()
        goalTableView.reloadData()
        configTableView()
    }
    
    private func configTableView() {
        if viewModel.goalsArr.isEmpty {
            let noGoalsView = NoGoalsHomeView(frame: goalTableView.frame)
            goalTableView.backgroundView = noGoalsView
            goalTableView.separatorStyle = .none
        } else {
            goalTableView.backgroundView = nil
            goalTableView.separatorStyle = .singleLine
        }
    }
    
    private func setTableView() {
        //TODO: create a custom uitableviewcell sometime
        //TODO: change the identifier to something more descriptive
        goalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        goalTableView.dataSource = self
        goalTableView.delegate = self
        view.addSubview(goalTableView)
        tableConstraints()
    }
    
    private func createNewGoalBtn() -> UIButton {
        let button = UIButton()
        button.setTitle("NEW", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 25
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(newGoalTapped), for: .touchUpInside)
        button.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        return button
    }
    
    private func buttonConstraints() {
        newGoalButton.translatesAutoresizingMaskIntoConstraints = false
        newGoalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        newGoalButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGoalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    private func tableConstraints() {
        goalTableView.translatesAutoresizingMaskIntoConstraints = false
        goalTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        goalTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        goalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        goalTableView.bottomAnchor.constraint(equalTo: newGoalButton.topAnchor, constant: -10).isActive = true
    }
}

extension HomeViewController {
    
    @objc func newGoalTapped() {
//        let vc = NewGoalViewController()
//        navigationController?.pushViewController(vc, animated: true)
        coordinator?.createNewGoal()
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        vc.goal = viewModel.goalsArr[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
        let goalToPass = viewModel.goalsArr[indexPath.row]
        coordinator?.goToDetailScreen(goal: goalToPass)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // create alert controller
            let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            // create action
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                // delete story from array & Core Data
                guard let resultList = self.viewModel.deleteGoal(indexPath: indexPath, goalList: self.viewModel.goalsArr) else { return }
                self.viewModel.goalsArr = resultList
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            alert.addAction(okAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configTableView()
        return viewModel.goalsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secondsInHour = 3600
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        let goalName = viewModel.goalsArr[indexPath.row].value(forKey: "title") as! String
        let goalSeconds = viewModel.goalsArr[indexPath.row].value(forKey: "totalSeconds") as! Int
        let goalHours = goalSeconds / secondsInHour
        let cellString = viewModel.getCellString(goalName: goalName, goalHours: String(goalHours))
        cell.textLabel?.text = cellString
        return cell
    }
}

