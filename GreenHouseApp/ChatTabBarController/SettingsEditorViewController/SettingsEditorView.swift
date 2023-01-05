//
//  SettingsEditorView.swift
//  GreenHouseApp
//
//  Created by Вадим on 05.01.2023.
//

import UIKit

protocol SettingsEditorViewControllerDelegate: AnyObject {
    func presentPicker()
}

class SettingsEditorView: UIView {
    
    weak var delegate: SettingsEditorViewControllerDelegate?
    
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
    
    let cityTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textfield.textColor = .darkGray
        textfield.layer.cornerRadius = 5
        textfield.text = "  *****"
        return textfield
    }()
    
    let birthDayTF: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textfield.textColor = .darkGray
        textfield.layer.cornerRadius = 5
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        textfield.inputAccessoryView = toolbar
        return textfield
    }()
    
    let dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.preferredDatePickerStyle = .inline
        dataPicker.datePickerMode = .date
        return dataPicker
    }()
    
    let aboutMeTV: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        textView.textColor = .darkGray
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
    
    private func setConstraints() {
        let stack = createStackView()
        self.addSubview(stack)
        
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
            aboutMeTV.widthAnchor.constraint(equalToConstant: 250),
            aboutMeTV.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [avatarImage,
                                                       userNameLabel,
                                                       phoneLabel,
                                                       cityTF,
                                                       birthDayTF,
                                                       aboutMeTV,
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
    
    @objc func doneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthDayTF.text = formatter.string(from: dataPicker.date)
        self.endEditing(true)
    }
    
}

fileprivate struct ConstantsForAvatar {
    static let avatarSize: CGFloat = 120
    static let offset: CGFloat = 20
}

