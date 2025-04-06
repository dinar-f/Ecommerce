//
//  TextField.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//

import UIKit

// MARK: - Public Properties
extension TextField {
    enum TextFieldType {
        case search
    }
}

final class TextField: UITextField {
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Images.navBar.search?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.Colors.brown
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var viewType: TextFieldType = .search
    
    init(type: TextFieldType) {
        super.init(frame: .zero)
        self.viewType = type
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 52, bottom: 8, right: 16))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 8, left: 52, bottom: 8, right: 16))
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let width: CGFloat = 30
        let height: CGFloat = bounds.height
        let x: CGFloat = 12
        return CGRect(x: x, y: (bounds.height - height) / 2, width: width, height: height)
    }
}

private extension TextField {
    
    func setupView() {
        font = .systemFont(ofSize: 18)
        textColor = .black
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = R.Colors.gray.cgColor
        leftView = searchImageView
        leftViewMode = .always
        placeholder = "Search"
        
        let placeholderColor = R.Colors.secondary
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor
        ]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
    
    private func setupLayout() {

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),
        
        ])
    }
}

//final class TextField: UITextField {
//    
//    var isValid = false
//    
//    override var isSecureTextEntry: Bool {
//        didSet {
//            imageview.image = isSecureTextEntry
//            ? UIImage(named: "eye")
//            : UIImage(named: "crossedEye")
//        }
//    }
//    
//    // MARK: Private Properties
//    private var viewType: TextFieldType = .email
//    
//    var viewState: TextFieldState = .normal {
//        didSet {
//            configureAppearance()
//        }
//    }
//    
//    private let imageview: UIImageView = {
//        let imageview = UIImageView()
//        imageview.isUserInteractionEnabled = true
//        imageview.contentMode = .scaleAspectFit
//        return imageview
//    }()
//    
//    init(type: TextFieldType) {
//        super.init(frame: .zero)
//        self.viewType = type
//        setupView()
//        configureAppearance()
//        configureType()
//        setupLayout()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
//    }
//    
//    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//        let width: CGFloat = 24
//        let height: CGFloat = bounds.height
//        let adjustedX = bounds.width - width - 16
//        return CGRect(x: adjustedX, y: (bounds.height - height) / 2, width: width, height: height)
//    }
//}
//
//// MARK: - Public Properties
//extension TextField {
//    enum TextFieldType {
//        case email
//        case password
//        case domain
//    }
//
//    enum TextFieldState {
//        case normal
//        case error
//        case active
//    }
//}
//
//// MARK: - Private Methods
//extension TextField {
//    @objc func togglePasswordVisibility() {
//        isSecureTextEntry.toggle()
//    }
//    
//    private func setupView() {
//        backgroundColor = UIColor(hex: "#F5F5F5")
//        font = .systemFont(ofSize: 16)
//        layer.cornerRadius = 12
//        layer.borderWidth = 1
//        layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
//        imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility)))
//    }
//    
//    private func setupLayout() {
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            heightAnchor.constraint(equalToConstant: 56),
//        ])
//    }
//    
//    private func configureAppearance(){
//        switch viewState {
//        case .normal:
//            layer.borderColor = UIColor(hex: "#E0E0E0")?.cgColor
//        case .error:
//            layer.borderColor = UIColor(hex: "#F54545")?.cgColor
//        case .active:
//            layer.borderColor = UIColor(hex: "#196CFC")?.cgColor
//        }
//    }
//    
//    private func configureType() {
//        switch viewType {
//        case .password:
//            isSecureTextEntry = true
//            placeholder = "Пароль"
//            rightView = imageview
//            rightViewMode = .always
//        case .email:
//            isSecureTextEntry = false
//            placeholder = "Email"
//        case .domain:
//            isSecureTextEntry = false
//            placeholder = "Рабочий домен"
//        }
//    }
//}
//
