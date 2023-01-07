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
    
    override func loadView() {
        self.view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        view().phoneLabel.text = phoneNumber
        view().userNameLabel.text = username
        view().cityLabel.text = city
        view().birthDayLabel.text = birthday
    }
    
    func view() -> SettingsView {
       return self.view as! SettingsView
    }
    
    init(phoneNumber: String, username: String?, city: String?, birthday: String?, vk: String?, instagram: String?) {
        self.phoneNumber = phoneNumber
        self.username = username
        self.city = city
        self.birthday = birthday
        self.vk = vk
        self.instagram = instagram
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SettingsViewController: SettingsViewControllerDelegate  {
    func settingsEditorAction() {
        let settingsEdditorVC = SettingsEditorViewController()
        self.navigationController?.pushViewController(settingsEdditorVC, animated: true)
    }
}
