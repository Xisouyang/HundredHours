//
//  DetailGoalView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/16/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    let timeStampsView = TimeStampsView(frame: .zero)
    
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    let trackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        timeStampsView.frame = self.frame
        let circle = createCircle(color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        self.layer.addSublayer(circle)
        addSubview(percentageLabel)
        percentageLabelConstraints()
        addSubview(timeStampsView)
        timeStampViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCircle(color: UIColor) -> CAShapeLayer {
        
        // create path
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.frame.width/3.5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 0.587603271, green: 0.578435719, blue: 0.594556272, alpha: 1)
        trackLayer.lineWidth = 12.5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.position = CGPoint(x: (self.frame.size.width)/2, y: (self.frame.size.height)/2)
        self.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 12.5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.position = CGPoint(x: (self.frame.size.width)/2, y: (self.frame.size.height)/2)
        shapeLayer.strokeEnd = 0
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        return shapeLayer
    }
    
    func animateBar(percentage: CGFloat) {
        
        CATransaction.begin()
        self.percentageLabel.text = "Loading"
        CATransaction.setCompletionBlock {
            print("animation done")
            let percentNum = String(format: "%.01f", Double(percentage) * 100)
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
    
    func percentageLabelConstraints() {
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        percentageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        percentageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        percentageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func timeStampViewConstraints() {
        
        timeStampsView.translatesAutoresizingMaskIntoConstraints = false
        timeStampsView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        timeStampsView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        timeStampsView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 80).isActive = true
        timeStampsView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
}
