//
//  SettingsViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 04.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func loadView() {
        self.view = SettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        getPhoneAndName()
        
    }
    
    func view() -> SettingsView {
       return self.view as! SettingsView
    }
    
    private func getPhoneAndName() {
        //ApiManager.shared
    }
}

extension SettingsViewController: SettingsViewControllerDelegate  {
    func settingsEditorAction() {
        let settingsEdditorVC = SettingsEditorViewController()
        self.navigationController?.pushViewController(settingsEdditorVC, animated: true)
    }
}
