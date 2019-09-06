//
//  ErrorView.swift
//  HundredHoursDev
//
//  Created by Stephen Ouyang on 9/6/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    let errorMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter correct input!"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        
        return label
    }()
    
    let errorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.cornerRadius = 75
        
        return view
    }()
    
    let errorCircleView: UIImageView = {
        let imageView = UIImageView()
        let errorCircleImage = UIImage(named: "errorCircle")
        imageView.image = errorCircleImage
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4018621575)
        
        addSubview(errorView)
        errorViewConstraints()
        
        errorView.addSubview(errorCircleView)
        errorCircleViewConstraints()
        
        errorView.addSubview(errorMsgLabel)
        errorLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func errorViewConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        errorView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        errorView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func errorCircleViewConstraints() {
        
        errorCircleView.translatesAutoresizingMaskIntoConstraints = false
        errorCircleView.topAnchor.constraint(equalToSystemSpacingBelow: errorView.topAnchor, multiplier: 8).isActive = true
        errorCircleView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
    }
    
    func errorLabelConstraints() {
        errorMsgLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMsgLabel.widthAnchor.constraint(equalTo: errorView.widthAnchor, multiplier: 0.8).isActive = true
        errorMsgLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        errorMsgLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        errorMsgLabel.topAnchor.constraint(equalToSystemSpacingBelow: errorCircleView.bottomAnchor, multiplier: 2).isActive = true
    }
}
