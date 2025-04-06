//
//  IconButton.swift
//  Ecommerce
//
//  Created by Dinar on 01.04.2025.
//

import UIKit

final class IconButton: UIButton {
    
    private let iconView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
        
    init(iconName: String) {
        super.init(frame: .zero)
        setupView(iconName: iconName)
        setupLayout()
        updateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
extension IconButton {
    
    private func setupView(iconName: String) {
        backgroundColor = .white
        iconView.image = UIImage(named: iconName)
        layer.cornerRadius = 12
        layer.borderWidth = 1
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    private func updateView() {
        
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}


