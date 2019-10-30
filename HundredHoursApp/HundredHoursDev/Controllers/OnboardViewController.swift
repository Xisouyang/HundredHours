//
//  OnboardViewController.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 10/24/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class OnboardViewController: UICollectionViewController {
    
    weak var coordinator: MainCoordinator?
    let viewModel = OnboardViewModel()
    private var startButton = UIButton(frame: .zero)
//    private var leftSwipe = UISwipeGestureRecognizer()
    private var pageControl = UIPageControl()
    private var currPageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configView() {
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView.register(OnboardPageCell.self, forCellWithReuseIdentifier: OnboardPageCell.identifier)
        collectionView.isPagingEnabled = true
        createButton()
        createPageControl()
//        configLeftSwipe()
    }
    
    private func createButton() {
        startButton = configStartButton()
        view.addSubview(startButton)
        startButtonConstraints()
    }
    
    private func createPageControl() {
        pageControl = configPageControl()
        view.addSubview(pageControl)
        pageControlConstraints()
    }
    
    private func configLeftSwipe() {
//        leftSwipe.delegate = self //as? UIGestureRecognizerDelegate
//        leftSwipe.numberOfTouchesRequired = 1
//        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        leftSwipe.direction = .left
        
        collectionView.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipedLeft() {
            startButton.isEnabled = false
            UIView.animate(withDuration: 0.1, animations: {
                self.startButton.alpha = 0
            })
    }
    
    private func configStartButton() -> UIButton {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.setTitle("START", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = #colorLiteral(red: 0.5105954409, green: 0.5106848478, blue: 0.5105836391, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        button.alpha = 0
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }
    
    private func configPageControl() -> UIPageControl {
        let control = UIPageControl()
        control.currentPage = 0
        control.numberOfPages = viewModel.dataSource.count
        control.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        control.pageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return control
    }
    
    private func startButtonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            ])
    }
    
    private func pageControlConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            pageControl.widthAnchor.constraint(equalToConstant: 100),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 65)
        ])
    }

    private func showButton(index: Int) {
        if index == viewModel.dataSource.count - 1 {
            startButton.isEnabled = true
            UIView.animate(withDuration: 0.25, animations: {
                self.startButton.alpha = 1
            })
        }
    }
    
    private func hideButton(index: Int) {
        if index <= viewModel.dataSource.count - 1 {
            startButton.isEnabled = false
            UIView.animate(withDuration: 0.25, animations: {
                self.startButton.alpha = 0
            })
        }
    }
    
    @objc private func startTapped() {
//        UserDefaults.standard.set(true, forKey: "onboarded")
        coordinator?.start()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardPageCell.identifier, for: indexPath) as! OnboardPageCell
        let onboardItem = viewModel.dataSource[indexPath.item]
        cell.onboardItem = onboardItem
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let rect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let point = CGPoint(x: rect.midX, y: rect.midY)
        let index = collectionView.indexPathForItem(at: point)
        if let unwrappedIndex = index {
            currPageIndex = unwrappedIndex.item
            pageControl.currentPage = currPageIndex
            showButton(index: currPageIndex)
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.x > 0 {
            hideButton(index: currPageIndex)
        }
    }
}

extension OnboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
}


