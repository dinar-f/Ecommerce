//
//  ColorSelectionView.swift
//  Ecommerce
//
//  Created by Dinar on 01.04.2025.
//

import UIKit

final class ColorSelectionView: UIView {
    
    let colors: [UIColor] = [.red, .blue, .green, .yellow, .purple]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Color"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constraintsViews()
        createColorCircles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


private extension ColorSelectionView {
    func setupViews() {
        addSubview(titleLabel)
        addSubview(stackView)
    }
    
    private func createColorCircles() {
        colors.forEach { color in
            let container = UIView()
            container.backgroundColor = .white
            container.layer.cornerRadius = 20
            container.layer.shadowColor = UIColor.black.cgColor
            container.layer.shadowOpacity = 0.15
            container.layer.shadowRadius = 4
            container.layer.shadowOffset = CGSize(width: 0, height: 2)
            
            let checkmarkIcon = UIImageView(image: R.Images.Common.checkmark)
            checkmarkIcon.tintColor = .systemBlue
            checkmarkIcon.translatesAutoresizingMaskIntoConstraints = false
            checkmarkIcon.isHidden = false
            
            let innerCircle = UIView()
            innerCircle.backgroundColor = color
            innerCircle.layer.cornerRadius = 15
            innerCircle.addSubview(checkmarkIcon)
            
            container.addSubview(innerCircle)
            innerCircle.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                container.widthAnchor.constraint(equalToConstant: 40),
                container.heightAnchor.constraint(equalToConstant: 40),
                
                innerCircle.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                innerCircle.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                innerCircle.widthAnchor.constraint(equalToConstant: 30),
                innerCircle.heightAnchor.constraint(equalToConstant: 30),
                
                checkmarkIcon.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 2),
                checkmarkIcon.topAnchor.constraint(equalTo: container.topAnchor, constant: -8),
                checkmarkIcon.widthAnchor.constraint(equalToConstant: 22),
                checkmarkIcon.heightAnchor.constraint(equalToConstant: 22),
            ])
            
            stackView.addArrangedSubview(container)
        }
    }
    
    func constraintsViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
