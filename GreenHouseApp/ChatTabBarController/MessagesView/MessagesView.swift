//
//  MessagesView.swift
//  GreenHouseApp
//
//  Created by Вадим on 11.01.2023.
//

import UIKit

class MessagesView: UIView {
    
    let messageField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Message..."
        textField.backgroundColor = .white
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = MessageCreatorConstants.itemsSize/2
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        return textField
    }()
    
    let mediaButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.Images.mediaButton), for: .normal)
        button.tintColor = .lightGray
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Constants.Images.sendButton), for: .normal)
        button.isEnabled = false
        button.tintColor = .lightGray
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.Colors.grayBackground
        configView()
    }
    
    func configView() {
        let stack = UIStackView(arrangedSubviews: [mediaButton, messageField, sendButton])
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        setConstraints(stack)
    }
    
    func setConstraints(_ stack: UIStackView) {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                           constant: MessageCreatorConstants.offsets),
            stack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                            constant: -MessageCreatorConstants.offsets),
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            mediaButton.widthAnchor.constraint(equalToConstant: MessageCreatorConstants.itemsSize),
            mediaButton.heightAnchor.constraint(equalToConstant: MessageCreatorConstants.itemsSize),
            sendButton.widthAnchor.constraint(equalToConstant: MessageCreatorConstants.itemsSize),
            sendButton.heightAnchor.constraint(equalToConstant: MessageCreatorConstants.itemsSize),
            messageField.heightAnchor.constraint(equalToConstant: MessageCreatorConstants.itemsSize)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

struct MessageCreatorConstants {
    static let offsets: CGFloat = 5
    static let itemsSize: CGFloat = 30
}

