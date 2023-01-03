//
//  SignUpView.swift
//  GreenHouseApp
//
//  Created by Вадим on 02.01.2023.
//

import Foundation
import UIKit

protocol SignUpViewControllerDelegate: AnyObject {
    func chatBarAction()
}

class SignUpView: UIView {
    
    weak var delegate: SignUpViewControllerDelegate?
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.text = "  +7927999999"
        return label
    }()
    
    let nameTF: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textField.textColor = .darkGray
        textField.placeholder = "Enter your name"
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.autocorrectionType = .no
        return textField
    }()
    
    let nicknameTF: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textField.textColor = .darkGray
        textField.placeholder = "Enter your nickname"
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.autocorrectionType = .no
        return textField
    }()
    
    var signUpButton: UIButton = {
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
        //setSubviews()
        setConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setConstraints() {
        let stack = createStackView()
        [signUpLabel, stack, signUpButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            signUpLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            
            phoneLabel.widthAnchor.constraint(equalToConstant: 250),
            phoneLabel.heightAnchor.constraint(equalToConstant: 50),
            nameTF.widthAnchor.constraint(equalToConstant: 250),
            nameTF.heightAnchor.constraint(equalToConstant: 50),
            nicknameTF.widthAnchor.constraint(equalToConstant: 250),
            nicknameTF.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.widthAnchor.constraint(equalToConstant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.centerYAnchor.constraint(equalTo: nicknameTF.centerYAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: nicknameTF.trailingAnchor, constant: 30),
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [phoneLabel,
                                                       nameTF,
                                                       nicknameTF])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setDelegates() {
        nameTF.delegate = self
        nicknameTF.delegate = self
    }
    
    @objc func addPressed() {
        delegate?.chatBarAction()
    }
}

extension SignUpView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        return string == filtered
    }
}
