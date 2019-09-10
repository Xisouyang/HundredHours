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
    
    var goalsArr: [NSManagedObject] = []
    var goalTableView = UITableView()
    
    var newGoalButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Goal", for: .normal)
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
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        populateGoalList()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.title = "Goals"
        setTableView()
        
        view.addSubview(newGoalButton)
        buttonConstraints()
    }
    
    func setTableView() {
        
        goalTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        goalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        goalTableView.dataSource = self
        goalTableView.delegate = self
        view.addSubview(goalTableView)
    }
    
    func buttonConstraints() {
        
        newGoalButton.translatesAutoresizingMaskIntoConstraints = false
        newGoalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        newGoalButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        newGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newGoalButton.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 84).isActive = true
    }
}

extension HomeViewController {
    
    func populateGoalList() {
        
        if let objArr = CoreDataManager.sharedManager.fetchAllGoals() {
            
            goalsArr = objArr
        }
    }
    
    @objc func newGoalTapped() {
        let vc = NewGoalViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // create alert controller
            let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
            // create action
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                // delete story from array & Core Data
                self.deleteGoal(indexPath: indexPath)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            alert.addAction(okAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    func deleteGoal(indexPath: IndexPath) {
        
        let goalName = goalsArr[indexPath.row].value(forKey: "title")
        let goalToRemove = CoreDataManager.sharedManager.fetchGoal(name: goalName as! String)
        let goalID = goalToRemove?.objectID
        guard let unwrappedID = goalID else { return }
        CoreDataManager.sharedManager.removeItem(objectID: unwrappedID)
        CoreDataManager.sharedManager.saveContext()
        goalsArr.remove(at: indexPath.row)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if goalsArr.isEmpty {
            tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            let noGoalsView = NoGoalsHomeView(frame: view.frame)
            tableView.backgroundView = noGoalsView
            tableView.separatorStyle = .none
            
        } else {
            tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.8)
        }
        
        return goalsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        
        let goalName = goalsArr[indexPath.row].value(forKey: "title") as! String
        let goalHours = goalsArr[indexPath.row].value(forKey: "totalHours") as! Int
        let cellString = getCellString(goalName: goalName, goalHours: String(goalHours))
        cell.textLabel?.text = cellString
        return cell
    }
    
    func getCellString(goalName: String, goalHours: String) -> String {

        var result: String = ""

        if Int(goalHours) == 1 {
            result = goalName + " - " + goalHours + " HOUR"
        } else {
            result = goalName + " - " + goalHours + " HOURS"
        }
        return result
    }
}

