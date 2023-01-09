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
    var filename: String?
    var base64: String?
    
    override func loadView() {
        self.view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view().cityLabel.text)
        view().delegate = self
        view().phoneLabel.text = "  \(phoneNumber)"
        view().userNameLabel.text = username
        view().cityLabel.text = city
        view().birthdayLabel.text = birthday
    }
    
    func view() -> SettingsView {
       return self.view as! SettingsView
    }
    
    init(phoneNumber: String, username: String?, city: String?, birthday: String?, vk: String?, instagram: String?, filename: String?, base64: String?) {
        self.phoneNumber = phoneNumber
        self.username = username ?? ""
        self.city = city ?? ""
        self.birthday = birthday ?? ""
        self.vk = vk ?? ""
        self.instagram = instagram ?? ""
        self.filename = filename ?? ""
        self.base64 = base64 ?? ""
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
