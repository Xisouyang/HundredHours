//
//  DetailGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit
import CoreData

class DetailView: UIView, UIGestureRecognizerDelegate {
        
    var timeStampView = UIView()
    var timeStampTitle = UILabel()
    var shapeLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    var percentageLabel = UILabel()
    var timeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let circle = createCircle(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        self.layer.addSublayer(circle)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeButton.layer.cornerRadius = timeButton.frame.width / 2
        layoutIfNeeded()
    }
    
    private func setupView() {
        percentageLabel = createPercentageLabel()
        timeButton = createTimeButton()
        timeStampView = createTimeStampView()
        timeStampTitle = createTimeStampTitle()
        addSubview(percentageLabel)
        addSubview(timeButton)
        addSubview(timeStampView)
        timeStampView.addSubview(timeStampTitle)
        percentageLabelConstraints()
        timeButtonConstraints()
        timeStampTitleConstraints()
    }
    
    private func createTimeStampView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/1.2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.borderWidth = 0.5
        view.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return view
    }
    
    private func createTimeStampTitle() -> UILabel {
        let label = UILabel()
        label.text = "Time Stamps"
        label.textAlignment = .left
        label.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        return label
    }
    
    private func createPercentageLabel() -> UILabel {
        let label = UILabel()
        label.text = "Start"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }
    
    private func createTimeButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setTitle("Timer", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .highlighted)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.borderWidth = 3
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 50
        return button
    }
    
    private func createCircle(color: UIColor) -> CAShapeLayer {
        // create path
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.frame.width/3.5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        configTrackLayer(path: circularPath)
        configShapeLayer(path: circularPath, color: color)
        self.layer.addSublayer(trackLayer)
        return shapeLayer
    }
    
    private func configTrackLayer(path: UIBezierPath) {
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 0.587603271, green: 0.578435719, blue: 0.594556272, alpha: 1)
        trackLayer.lineWidth = 12.5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.position = CGPoint(x: (self.frame.size.width)/2, y: (self.frame.size.height)/2)
    }
    
    private func configShapeLayer(path: UIBezierPath, color: UIColor) {
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 12.5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.position = CGPoint(x: (self.frame.size.width)/2, y: (self.frame.size.height)/2)
        shapeLayer.strokeEnd = 0
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    }
    
    func animateBar(percentage: CGFloat) {
        CATransaction.begin()
        self.percentageLabel.text = "Loading..."
        CATransaction.setCompletionBlock {
            let percentNum = String(format: "%.1f", CGFloat(percentage * 100))
            self.percentageLabel.text = "\(percentNum)%"
        }
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = percentage
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "keyOne")
        CATransaction.commit()
    }
    
    func viewDragged(gesture: UIPanGestureRecognizer) {
        let buffer: CGFloat = 135
        let recognizer = gesture
        let translation = recognizer.translation(in: self)
        var frame = timeStampView.frame
        let viewHeight = timeStampView.frame.origin.y + translation.y
        if viewHeight > buffer {
            frame.origin.y = viewHeight
            timeStampView.frame = frame
            recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self)
        } else if viewHeight == buffer {
            timeStampView.frame = frame
        }
    }
    
    func addBlur() {
        self.blurScreen()
    }
    
    func removeBlur() {
        self.removeBlurEffect()
    }
    
    private func timeStampTitleConstraints() {
        timeStampTitle.translatesAutoresizingMaskIntoConstraints = false
        timeStampTitle.widthAnchor.constraint(equalTo: timeStampView.widthAnchor, multiplier: 0.6).isActive = true
        timeStampTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        timeStampTitle.topAnchor.constraint(equalToSystemSpacingBelow: timeStampView.topAnchor, multiplier: 2).isActive = true
        timeStampTitle.leftAnchor.constraint(equalToSystemSpacingAfter: timeStampView.leftAnchor, multiplier: 2).isActive = true
    }
    
    private func percentageLabelConstraints() {
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        percentageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        percentageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        percentageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func timeButtonConstraints() {
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.18).isActive = true
        timeButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.18).isActive = true
        timeButton.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: self.frame.height * 0.08).isActive = true
        timeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
}
