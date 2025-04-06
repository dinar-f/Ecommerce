//
//  ColorCircleView.swift
//  Ecommerce
//
//  Created by Dinar on 01.04.2025.
//

import UIKit

final class ColorCircleView: UIView {
    
    private let backgroundCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }()
    
    private let innerCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constraintsViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        innerCircle.layoutIfNeeded()
        backgroundCircle.layer.cornerRadius = backgroundCircle.bounds.width / 2
        innerCircle.layer.cornerRadius = innerCircle.bounds.width / 2
    }
}


private extension ColorCircleView {
    func setupViews() {
        addSubview(backgroundCircle)
        backgroundCircle.addSubview(innerCircle)
    }
    
    func constraintsViews() {
        backgroundCircle.translatesAutoresizingMaskIntoConstraints = false
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundCircle.topAnchor.constraint(equalTo: topAnchor),
            backgroundCircle.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundCircle.widthAnchor.constraint(equalTo: widthAnchor, constant: 40),
            backgroundCircle.heightAnchor.constraint(equalTo: backgroundCircle.widthAnchor),
            
            innerCircle.centerXAnchor.constraint(equalTo: backgroundCircle.centerXAnchor),
            innerCircle.centerYAnchor.constraint(equalTo: backgroundCircle.centerYAnchor),
            innerCircle.widthAnchor.constraint(equalToConstant: 30),
            innerCircle.heightAnchor.constraint(equalTo: innerCircle.widthAnchor),
        ])
    }
}
