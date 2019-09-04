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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = "Goals"
        
        if HomeViewController.goalsArr.isEmpty {
            useEmptyStateView()
            
        }
    }
    
    func useEmptyStateView() {
        let emptyView = NoGoalsView(frame: view.frame)
        view.addSubview(emptyView)
        emptyView.newGoalButton.addTarget(self, action: #selector(newGoalTapped), for: .touchUpInside)
    }
}

extension HomeViewController {
    
    @objc func newGoalTapped() {
        print("tapped")
    }
}

