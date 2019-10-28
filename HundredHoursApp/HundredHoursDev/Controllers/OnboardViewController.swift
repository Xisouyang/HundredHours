//
//  OnboardViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class OnboardViewController: UICollectionViewController {
    
    let viewModel = OnboardViewModel()
    private var startButton = UIButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configView() {
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView.register(OnboardPageCell.self, forCellWithReuseIdentifier: OnboardPageCell.identifier)
        collectionView.isPagingEnabled = true
        createButton()
    }
    
    private func createButton() {
        startButton = configStartButton()
        view.addSubview(startButton)
        startButtonConstraints()
    }
    
    private func configStartButton() -> UIButton {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        button.alpha = 0
        return button
    }
    
    private func toggleButton(index: Int) {
        if index < viewModel.dataSource.count - 1 {
            startButton.isEnabled = false
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 0
            })
        } else {
            startButton.isEnabled = true
            UIView.animate(withDuration: 0.75, animations: {
                self.startButton.alpha = 1
            })
        }
    }
    
    private func startButtonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardPageCell.identifier, for: indexPath) as! OnboardPageCell
        let onboardText = viewModel.dataSource[indexPath.item]
        cell.onboardText = onboardText
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let rect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let point = CGPoint(x: rect.midX, y: rect.midY)
        let index = collectionView.indexPathForItem(at: point)
        if let unwrappedIndex = index {
            print("current page index: \(unwrappedIndex.item)")
            toggleButton(index: unwrappedIndex.item)
        }
    }
}

extension OnboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


