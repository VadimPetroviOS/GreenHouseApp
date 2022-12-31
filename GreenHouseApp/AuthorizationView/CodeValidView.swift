//
//  CodeValidView.swift
//  GreenHouseApp
//
//  Created by Вадим on 30.12.2022.
//

import Foundation
import UIKit

protocol CodeValidViewControllerDelegate: AnyObject {
    
}

class CodeValidView: UIView {
    
    weak var delegate: CodeValidViewControllerDelegate?
    
    var codeTV: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 21)
        textView.textAlignment = .center
        textView.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textView.textColor = .darkGray
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    var checkCodeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .green
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
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
        self.addSubview(codeTV)
        self.addSubview(checkCodeButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            codeTV.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40),
            codeTV.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            codeTV.widthAnchor.constraint(equalToConstant: 250),
            codeTV.heightAnchor.constraint(equalToConstant: 50),
            
            checkCodeButton.widthAnchor.constraint(equalToConstant: 50),
            checkCodeButton.heightAnchor.constraint(equalToConstant: 50),
            checkCodeButton.centerYAnchor.constraint(equalTo: codeTV.centerYAnchor),
            checkCodeButton.leadingAnchor.constraint(equalTo: codeTV.trailingAnchor, constant: 30),
        ])
    }
}

