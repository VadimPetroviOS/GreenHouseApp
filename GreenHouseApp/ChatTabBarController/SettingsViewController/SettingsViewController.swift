//
//  SettingsViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 04.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    var phoneNumber: String
    var username: String?
    var city: String?
    var birthday: String?
    var vk: String?
    var instagram: String?
    var avatar: String
    
    override func loadView() {
        self.view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().backgroundColor = Colors.grayBackground
        view().delegate = self
        view().phoneLabel.text = "  \(phoneNumber)"
        view().userNameLabel.text = "  \(username!)"
        view().cityLabel.text = "  \(city!)"
        view().birthdayLabel.text = "  \(birthday!)"
        view().vkLabel.text = "  \(vk!)"
        view().instaLabel.text = "  \(instagram!)"
        
       
        let newImageData = Data(base64Encoded: avatar, options: .ignoreUnknownCharacters)
        if let newImageData = newImageData {
            view().avatarView.image = UIImage(data: newImageData)
        }
        
        //view().reloadInputViews()
    }
    
    func view() -> SettingsView {
       return self.view as! SettingsView
    }
    
    init(phoneNumber: String, username: String?, city: String?, birthday: String?, vk: String?, instagram: String?, avatar: String?) {
        self.phoneNumber = phoneNumber
        self.username = username ?? ""
        self.city = city ?? ""
        self.birthday = birthday ?? ""
        self.vk = vk ?? ""
        self.instagram = instagram ?? ""
        self.avatar = avatar ?? ""
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension SettingsViewController: SettingsViewControllerDelegate  {
    func settingsEditorAction() {
        let settingsEdditorVC = SettingsEditorViewController()
        present(settingsEdditorVC, animated: true)
    }
}


