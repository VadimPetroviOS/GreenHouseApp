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
        let imageView = UIImageView()
        imageView.layer.cornerRadius = ConstantsForAvatar.avatarSize/2
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "camera")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    let birthdayLabel: UILabel = {
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
        label.textColor = .black
        label.text = "About Me"
        return label
    }()
    
    let vkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.text = "  vk.com/"
        return label
    }()
    
    let instaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        label.textColor = .darkGray
        label.layer.cornerRadius = 5
        label.text = "  www.instagram.com/"
        return label
    }()
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setSubviews() {
        self.addSubview(aboutMeLabel)
        aboutMeLabel.addSubview(vkLabel)
        aboutMeLabel.addSubview(instaLabel)
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
            birthdayLabel.widthAnchor.constraint(equalToConstant: 250),
            birthdayLabel.heightAnchor.constraint(equalToConstant: 50),
            
            aboutMeLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor,constant: 10),
            aboutMeLabel.leadingAnchor.constraint(equalTo: birthdayLabel.leadingAnchor),
            vkLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor,constant: 10),
            vkLabel.leadingAnchor.constraint(equalTo: aboutMeLabel.leadingAnchor),
            vkLabel.widthAnchor.constraint(equalToConstant: 250),
            vkLabel.heightAnchor.constraint(equalToConstant: 50),
            instaLabel.topAnchor.constraint(equalTo: vkLabel.bottomAnchor,constant: 10),
            instaLabel.leadingAnchor.constraint(equalTo: vkLabel.leadingAnchor),
            instaLabel.widthAnchor.constraint(equalToConstant: 250),
            instaLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [avatarView,
                                                       userNameLabel,
                                                       phoneLabel,
                                                       cityLabel,
                                                       birthdayLabel,
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
}
