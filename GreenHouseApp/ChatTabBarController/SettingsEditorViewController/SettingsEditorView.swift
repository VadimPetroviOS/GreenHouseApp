//
//  SettingsEditorView.swift
//  GreenHouseApp
//
//  Created by Вадим on 05.01.2023.
//

import UIKit

protocol SettingsEditorViewControllerDelegate: AnyObject {
    func presentPicker()
    func saveSettings()
}

class SettingsEditorView: UIView {
    
    weak var delegate: SettingsEditorViewControllerDelegate?
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        UIView().layoutIfNeeded()
        return button
    }()
    
    let avatarImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = ConstantsForAvatar.avatarSize/2
        image.clipsToBounds = true
        image.image = UIImage(systemName: "camera")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
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
    
    let cityTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textfield.textColor = .darkGray
        textfield.layer.cornerRadius = 5
        textfield.placeholder = "   city"
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.leftView = spacerView
        return textfield
    }()
    
    let birthDayTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textfield.textColor = .darkGray
        textfield.layer.cornerRadius = 5
        textfield.placeholder = "   date"
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        textfield.inputAccessoryView = toolbar
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.leftView = spacerView
        return textfield
    }()
    
    let dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.preferredDatePickerStyle = .inline
        dataPicker.datePickerMode = .date
        return dataPicker
    }()
    
    let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "About Me"
        return label
    }()
    
    let vkTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textfield.textColor = .darkGray
        textfield.layer.cornerRadius = 5
        textfield.placeholder = "  vk.com/"
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.leftView = spacerView
        return textfield
    }()
    
    let instaTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textfield.textColor = .darkGray
        textfield.layer.cornerRadius = 5
        textfield.placeholder = "  www.instagram.com/"
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textfield.leftViewMode = UITextField.ViewMode.always
        textfield.leftView = spacerView
        return textfield
    }()
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.grayBackground
        phoneLabel.text = "  \(Base.shared.userData[0].phone!)"
        userNameLabel.text = "  \(Base.shared.userData[0].username!)"
        setConstraints()
        configAvatar()
        setDataPicker()
        
    }
    
    private func setDataPicker() {
        birthDayTF.inputView = dataPicker
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setSubviews() {
        self.addSubview(saveButton)
        self.addSubview(aboutMeLabel)
        self.addSubview(vkTF)
        self.addSubview(instaTF)
    }
    
    private func setConstraints() {
        let stack = createStackView()
        self.addSubview(stack)
        setSubviews()
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            avatarImage.widthAnchor.constraint(equalToConstant: ConstantsForAvatar.avatarSize),
            avatarImage.heightAnchor.constraint(equalToConstant: ConstantsForAvatar.avatarSize),
            userNameLabel.widthAnchor.constraint(equalToConstant: 250),
            userNameLabel.heightAnchor.constraint(equalToConstant: 50),
            phoneLabel.widthAnchor.constraint(equalToConstant: 250),
            phoneLabel.heightAnchor.constraint(equalToConstant: 50),
            cityTF.widthAnchor.constraint(equalToConstant: 250),
            cityTF.heightAnchor.constraint(equalToConstant: 50),
            birthDayTF.widthAnchor.constraint(equalToConstant: 250),
            birthDayTF.heightAnchor.constraint(equalToConstant: 50),
            
            aboutMeLabel.topAnchor.constraint(equalTo: birthDayTF.bottomAnchor,constant: 10),
            aboutMeLabel.leadingAnchor.constraint(equalTo: birthDayTF.leadingAnchor),
            vkTF.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor,constant: 10),
            vkTF.leadingAnchor.constraint(equalTo: aboutMeLabel.leadingAnchor),
            vkTF.widthAnchor.constraint(equalToConstant: 250),
            vkTF.heightAnchor.constraint(equalToConstant: 50),
            instaTF.topAnchor.constraint(equalTo: vkTF.bottomAnchor,constant: 10),
            instaTF.leadingAnchor.constraint(equalTo: vkTF.leadingAnchor),
            instaTF.widthAnchor.constraint(equalToConstant: 250),
            instaTF.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -75),
            saveButton.widthAnchor.constraint(equalToConstant: 25),
            saveButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [avatarImage,
                                                       userNameLabel,
                                                       phoneLabel,
                                                       cityTF,
                                                       birthDayTF,
                                                       view])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func configAvatar() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(avatarTapped))
        avatarImage.addGestureRecognizer(tapGesture)
    }
    
    @objc private func avatarTapped(_ gesture: UITapGestureRecognizer){
        delegate?.presentPicker()
    }
    
    @objc private func doneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthDayTF.text = formatter.string(from: dataPicker.date)
        self.endEditing(true)
    }
    
    @objc private func addPressed() {
        delegate?.saveSettings()
    }
    
}

fileprivate struct ConstantsForAvatar {
    static let avatarSize: CGFloat = 120
}

