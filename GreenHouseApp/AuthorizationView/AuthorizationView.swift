//
//  AuthorizationView.swift
//  GreenHouseApp
//
//  Created by Вадим on 28.12.2022.
//

import UIKit
import FlagPhoneNumber

protocol AuthorizationViewControllerDelegate: AnyObject {
    func codeValidAction()
}

class AuthorizationView: UIView {
    
    
    
    weak var delegate: AuthorizationViewControllerDelegate?
    
    
    var phoneTF: FPNTextField = {
        let textField = FPNTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textField.textColor = .darkGray
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .green
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        UIView().layoutIfNeeded()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setSubviews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setSubviews() {
        self.addSubview(phoneTF)
        self.addSubview(nextButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            phoneTF.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40),
            phoneTF.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            phoneTF.widthAnchor.constraint(equalToConstant: 250),
            phoneTF.heightAnchor.constraint(equalToConstant: 50),
            
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.centerYAnchor.constraint(equalTo: phoneTF.centerYAnchor),
            nextButton.leadingAnchor.constraint(equalTo: phoneTF.trailingAnchor, constant: 30),
        ])
    }
    
    @objc func addPressed() {
        delegate?.codeValidAction()
    }
}



