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
    private var pageControl = UIPageControl()
    private var currPageIndex = 0
    private let notificationObj: NotificationService
    
    init(_ notificationObj: NotificationService, _ layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .horizontal
        self.notificationObj = notificationObj
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6881616712, green: 0, blue: 1, alpha: 1)
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
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OnboardPageCell.self, forCellWithReuseIdentifier: OnboardPageCell.identifier)
        collectionView.isPagingEnabled = true
        createButton()
        createPageControl()
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
    
    private func configStartButton() -> UIButton {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.6509808302, green: 0.006794857327, blue: 0.9529710412, alpha: 1)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.alpha = 0
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }
    
    private func configPageControl() -> UIPageControl {
        let control = UIPageControl()
        control.currentPage = 0
        control.numberOfPages = viewModel.dataSource.count
        control.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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

    private func toggleButton(index: Int) {
        if index == viewModel.dataSource.count - 1 {
            startButton.isEnabled = true
            UIView.animate(withDuration: 0.25, animations: {
                self.startButton.alpha = 1
            })
        } else {
            startButton.isEnabled = false
            UIView.animate(withDuration: 0.25, animations: {
                self.startButton.alpha = 0
            })
        }
    }
    
    @objc private func startTapped() {
        UserDefaults.standard.set(true, forKey: "onboarded")
        notificationObj.requestNotifications() { success in
            if success {
                DispatchQueue.main.async {
                    self.coordinator?.start()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardPageCell.identifier, for: indexPath) as! OnboardPageCell
        let onboardItem = viewModel.dataSource[indexPath.item]
        cell.configureCell(with: onboardItem)
        return cell
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        toggleButton(index: pageControl.currentPage)
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


