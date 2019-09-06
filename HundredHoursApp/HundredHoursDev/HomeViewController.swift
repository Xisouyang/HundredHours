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

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension HomeViewController {
    
    @objc func newGoalTapped() {
        print("tapped")
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
        }
        
        return HomeViewController.goalsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID", for: indexPath)
        return cell
    }
}

