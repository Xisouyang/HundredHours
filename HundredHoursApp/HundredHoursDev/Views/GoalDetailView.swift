//
//  DetailGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit
import CoreData

class GoalDetailView: UIView, UIGestureRecognizerDelegate {
        
    var timeStampView = UIView()
    var timeStampTitle = UILabel()
    var shapeLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    var percentageLabel = UILabel()
    var timeButton = UIButton()
    private var grayBar = UIView()
    private let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.width/3.5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    
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
        grayBar = createGrayBar()
        addSubview(percentageLabel)
        addSubview(timeButton)
        addSubview(timeStampView)
        timeStampView.addSubview(timeStampTitle)
        timeStampView.addSubview(grayBar)
        percentageLabelConstraints()
        timeButtonConstraints()
        timeStampTitleConstraints()
        grayBarConstraints()
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
        label.text = "Finished work sessions"
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
        button.setTitle("Start", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .highlighted)
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.borderWidth = 3
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 50
        return button
    }

    private func createGrayBar() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        view.layer.cornerRadius = 3
        return view
    }
    
    private func createCircle(color: UIColor) -> CAShapeLayer {
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
        if percentage == 0 {
            self.percentageLabel.text = "0.0%"
        } else {
            self.percentageLabel.text = "Loading..."
            CATransaction.setCompletionBlock {
                let percentNum = String(format: "%.1f", CGFloat(percentage * 100))
                self.percentageLabel.text = "\(percentNum)%"
            }
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.toValue = percentage
            basicAnimation.setValue(shapeLayer, forKey: "stroke")
            let colorAnimation = CAKeyframeAnimation(keyPath: "strokeColor")
            changeBarColor(percentage: percentage, colorAnimation: colorAnimation)
            let group = CAAnimationGroup()
            group.animations = [basicAnimation, colorAnimation]
            group.duration = 1
            group.fillMode = .forwards
            group.isRemovedOnCompletion = false
            shapeLayer.add(group, forKey: nil)
            CATransaction.commit()
        }
    }

    func changeBarColor(percentage: CGFloat, colorAnimation: CAKeyframeAnimation) {
        switch percentage {
        case 0..<0.1:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0]
        case 0.1..<0.2:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8059636354, green: 0.02990280278, blue: 0.3326860368, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.5]
        case 0.2..<0.3:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.33, 0.66]
        case 0.3..<0.4:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor, #colorLiteral(red: 0.9965577722, green: 0.2738482654, blue: 0.0822692439, alpha: 1).cgColor, #colorLiteral(red: 0.9678358436, green: 0.6313350797, blue: 0.3342870772, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8]
        case 0.4..<0.5:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor, #colorLiteral(red: 0.9965577722, green: 0.2738482654, blue: 0.0822692439, alpha: 1).cgColor, #colorLiteral(red: 0.9678358436, green: 0.6313350797, blue: 0.3342870772, alpha: 1).cgColor, #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.16, 0.32, 0.48, 0.64, 0.8]
        case 0.5..<0.6:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor, #colorLiteral(red: 0.9965577722, green: 0.2738482654, blue: 0.0822692439, alpha: 1).cgColor, #colorLiteral(red: 0.9678358436, green: 0.6313350797, blue: 0.3342870772, alpha: 1).cgColor, #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor, #colorLiteral(red: 0.967400372, green: 0.8992069364, blue: 0.1636879742, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.14, 0.28, 0.42, 0.56, 0.7, 0.84]
        case 0.6..<0.7:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor, #colorLiteral(red: 0.9965577722, green: 0.2738482654, blue: 0.0822692439, alpha: 1).cgColor, #colorLiteral(red: 0.9678358436, green: 0.6313350797, blue: 0.3342870772, alpha: 1).cgColor, #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor,#colorLiteral(red: 0.967400372, green: 0.8992069364, blue: 0.1636879742, alpha: 1).cgColor, #colorLiteral(red: 0.8471344113, green: 0.9593222737, blue: 0.1737907827, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875]
        case 0.7..<0.8:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor, #colorLiteral(red: 0.9965577722, green: 0.2738482654, blue: 0.0822692439, alpha: 1).cgColor, #colorLiteral(red: 0.9678358436, green: 0.6313350797, blue: 0.3342870772, alpha: 1).cgColor, #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor, #colorLiteral(red: 0.967400372, green: 0.8992069364, blue: 0.1636879742, alpha: 1).cgColor, #colorLiteral(red: 0.8471344113, green: 0.9593222737, blue: 0.1737907827, alpha: 1).cgColor, #colorLiteral(red: 0.6713312268, green: 0.9637488723, blue: 0.1907143891, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.11, 0.22, 0.33, 0.44, 0.55, 0.66, 0.77, 0.88]
        case 0.8..<0.9:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor, #colorLiteral(red: 0.9965577722, green: 0.2738482654, blue: 0.0822692439, alpha: 1).cgColor, #colorLiteral(red: 0.9678358436, green: 0.6313350797, blue: 0.3342870772, alpha: 1).cgColor, #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor, #colorLiteral(red: 0.967400372, green: 0.8992069364, blue: 0.1636879742, alpha: 1).cgColor, #colorLiteral(red: 0.8471344113, green: 0.9593222737, blue: 0.1737907827, alpha: 1).cgColor, #colorLiteral(red: 0.6713312268, green: 0.9637488723, blue: 0.1907143891, alpha: 1).cgColor, #colorLiteral(red: 0.2960849106, green: 0.9690691829, blue: 0.4863678217, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]
        case 0.9...1:
            colorAnimation.values = [#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.9956461787, green: 0.2944359183, blue: 0.405433625, alpha: 1).cgColor, #colorLiteral(red: 0.9965577722, green: 0.2738482654, blue: 0.0822692439, alpha: 1).cgColor, #colorLiteral(red: 0.9678358436, green: 0.6313350797, blue: 0.3342870772, alpha: 1).cgColor, #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor, #colorLiteral(red: 0.967400372, green: 0.8992069364, blue: 0.1636879742, alpha: 1).cgColor, #colorLiteral(red: 0.8471344113, green: 0.9593222737, blue: 0.1737907827, alpha: 1).cgColor, #colorLiteral(red: 0.6713312268, green: 0.9637488723, blue: 0.1907143891, alpha: 1).cgColor, #colorLiteral(red: 0.2960849106, green: 0.9690691829, blue: 0.4863678217, alpha: 1).cgColor, #colorLiteral(red: 0, green: 1, blue: 0.2938817739, alpha: 1).cgColor]
            colorAnimation.keyTimes = [0, 0.09, 0.18, 0.27, 0.36, 0.45, 0.54, 0.63, 0.72, 0.81, 0.9]
        default:
            break
        }
    }
    
    func viewDragged(gesture: UIPanGestureRecognizer) {
        configViewFrame(gesture: gesture)
        configViewBrightness()
        if gesture.state == UIPanGestureRecognizer.State.ended {
            
        }
    }

    private func configViewFrame(gesture: UIPanGestureRecognizer) {
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

    private func configViewBrightness() {
        if timeStampView.frame.origin.y < timeStampView.frame.height / 2 {
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
            })
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundColor = UIColor.white
            })
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
        timeStampTitle.widthAnchor.constraint(equalTo: timeStampView.widthAnchor, multiplier: 0.8).isActive = true
        timeStampTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        timeStampTitle.topAnchor.constraint(equalToSystemSpacingBelow: timeStampView.topAnchor, multiplier: 2).isActive = true
        timeStampTitle.leftAnchor.constraint(equalToSystemSpacingAfter: timeStampView.leftAnchor, multiplier: 2).isActive = true
    }

    private func grayBarConstraints() {
        grayBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            grayBar.widthAnchor.constraint(equalTo: timeStampTitle.widthAnchor, multiplier: 0.15),
            grayBar.heightAnchor.constraint(equalToConstant: 6),
            grayBar.centerXAnchor.constraint(equalTo: timeStampView.centerXAnchor),
            grayBar.topAnchor.constraint(equalToSystemSpacingBelow: timeStampView.topAnchor, multiplier: 1.5)
        ])
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
