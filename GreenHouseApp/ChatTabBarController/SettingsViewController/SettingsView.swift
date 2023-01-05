//
//  SettingsView.swift
//  GreenHouseApp
//
//  Created by Вадим on 04.01.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsEditorAction()
}

class SettingsView: UIView {
    
    weak var delegate: SettingsViewControllerDelegate?
    
    var editorButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .systemGray
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        UIView().layoutIfNeeded()
        return button
    }()
    
    let avatarView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = ConstantsForAvatar.avatarSize/2
        image.clipsToBounds = true
        image.image = UIImage(systemName: "camera")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "  **** ******"
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.text = "  +7927999999"
        label.layer.cornerRadius = 5
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.text = "  *****"
        return label
    }()
    
    let birthDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.text = "  *****"
        return label
    }()
    
    let zodiacImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.text = ""
        return label
    }()
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setConstraints() {
        let stack = createStackView()
        self.addSubview(stack)
        self.addSubview(editorButton)
       
        NSLayoutConstraint.activate([
            editorButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            editorButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -75),
            editorButton.widthAnchor.constraint(equalToConstant: 25),
            editorButton.heightAnchor.constraint(equalToConstant: 25),
            
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            avatarView.widthAnchor.constraint(equalToConstant: ConstantsForAvatar.avatarSize),
            avatarView.heightAnchor.constraint(equalToConstant: ConstantsForAvatar.avatarSize),
            userNameLabel.widthAnchor.constraint(equalToConstant: 250),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
            phoneLabel.widthAnchor.constraint(equalToConstant: 250),
            phoneLabel.heightAnchor.constraint(equalToConstant: 50),
            cityLabel.widthAnchor.constraint(equalToConstant: 250),
            cityLabel.heightAnchor.constraint(equalToConstant: 50),
            birthDayLabel.widthAnchor.constraint(equalToConstant: 250),
            birthDayLabel.heightAnchor.constraint(equalToConstant: 50),
            aboutMeLabel.widthAnchor.constraint(equalToConstant: 250),
            aboutMeLabel.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [avatarView,
                                                       userNameLabel,
                                                       phoneLabel,
                                                       cityLabel,
                                                       birthDayLabel,
                                                       aboutMeLabel,
                                                       view])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    @objc private func addPressed() {
        delegate?.settingsEditorAction()
    }
}

fileprivate struct ConstantsForAvatar {
    static let avatarSize: CGFloat = 120
    static let offset: CGFloat = 20
}
