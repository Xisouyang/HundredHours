//
//  OnboardViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class OnboardViewController: UICollectionViewController {
    
    let dataSource: [OnboardText] = [
        OnboardText(title: "title one", description: "description one"),
        OnboardText(title: "title two", description: "description two"),
        OnboardText(title: "title three", description: "description three")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        collectionView.register(OnboardPageCell.self, forCellWithReuseIdentifier: OnboardPageCell.identifier)
        collectionView.isPagingEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardPageCell.identifier, for: indexPath) as! OnboardPageCell
        cell.backgroundColor = indexPath.item % 2 == 0 ? .orange : .yellow
        cell.titleLabel.text = dataSource[indexPath.item].title
        cell.descriptionLabel.text = dataSource[indexPath.item].description
        return cell
    }
}

extension OnboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


