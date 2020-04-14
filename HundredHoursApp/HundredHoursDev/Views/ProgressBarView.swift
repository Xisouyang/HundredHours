//
//  HomeView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 4/4/20.
//  Copyright © 2020 Stephen Ouyang. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    let shapeLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        let circle = createCircle(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        self.layer.addSublayer(circle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCircle(color: UIColor) -> CAShapeLayer {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.bounds.height / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        configTrackLayer(path: circularPath)
        configShapeLayer(path: circularPath, color: color)
        self.layer.addSublayer(trackLayer)
        return shapeLayer
    }
    
    private func configTrackLayer(path: UIBezierPath) {
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 0.8162947297, green: 0.4984353781, blue: 1, alpha: 1)
        trackLayer.lineWidth = 7
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
    }
    
    private func configShapeLayer(path: UIBezierPath, color: UIColor) {
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 7
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        shapeLayer.strokeEnd = 0
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    }
}
