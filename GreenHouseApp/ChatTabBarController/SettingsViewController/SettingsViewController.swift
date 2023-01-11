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
        // Не успел сделать картинки знаков зодиака
        super.viewDidLoad()
        view().backgroundColor = Colors.grayBackground
        view().delegate = self
        view().phoneLabel.text = "  \(phoneNumber)"
        view().userNameLabel.text = "  \(username!)"
        view().cityLabel.text = "  \(city!)"
        view().birthdayLabel.text = "  \(birthday!)"
        view().vkLabel.text = "  \(vk!)"
        view().instaLabel.text = "  \(instagram!)"
        
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
        settingsEdditorVC.callback = {
            self.view().cityLabel.text = "  \(Base.shared.userData[0].city!)"
            self.view().birthdayLabel.text = "  \(Base.shared.userData[0].birthday!)"
            self.view().vkLabel.text = "  \(Base.shared.userData[0].vk!)"
            self.view().instaLabel.text = "  \(Base.shared.userData[0].instagram!)"
        }
        present(settingsEdditorVC, animated: true)
    }
}


