//
//  ViewController.swift
//  100HoursDev
//
//  Created by Stephen Ouyang on 9/2/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    static var goalsArr: [String] = []
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
        
        var data: [String] = []
        
        if let objArr = CoreDataManager.sharedManager.fetchAllGoalTitleObjs() {
            for item in objArr {
                if let goalName = item.value(forKey: "name") {
                    data.append(goalName as! String)
                }
            }
            
            HomeViewController.goalsArr = data
        }
        
    }
    
    @objc func newGoalTapped() {
        let vc = NewGoalViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if HomeViewController.goalsArr.isEmpty {
            let noGoalsView = NoGoalsHomeView(frame: view.frame)
            tableView.backgroundView = noGoalsView
            noGoalsView.newGoalButton.addTarget(self, action: #selector(newGoalTapped), for: .touchUpInside)
            tableView.separatorStyle = .none
        } else {
            tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.8)
            view.addSubview(newGoalButton)
            buttonConstraints()
        }
        
        return HomeViewController.goalsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        cell.textLabel?.text = HomeViewController.goalsArr[indexPath.row]
        return cell
    }
}

