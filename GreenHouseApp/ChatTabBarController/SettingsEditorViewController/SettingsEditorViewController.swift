//
//  SettingsEditorViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 05.01.2023.
//

import UIKit

class SettingsEditorViewController: UIViewController {
    
    var callback: (() -> Void)?
    
    override func loadView() {
        self.view = SettingsEditorView()
    }
    override func viewDidLoad() {
        // Не успел сделать модуль сохранения картинки
        super.viewDidLoad()
        view().delegate = self
    }

    fileprivate func view() -> SettingsEditorView {
        return self.view as! SettingsEditorView
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view().endEditing(true)
    }
}

extension SettingsEditorViewController: SettingsEditorViewControllerDelegate {
    func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func saveSettings() {
        
        Base.shared.userData[0].city = view().cityTF.text
        Base.shared.userData[0].birthday = view().birthDayTF.text
        Base.shared.userData[0].vk = view().vkTF.text
        Base.shared.userData[0].instagram = view().instaTF.text
        self.callback?()
        
        guard let refreshToken = Base.shared.userData[0].refreshToken else { return }
        ApiManager.shared.refreshToken(refreshToken: refreshToken) { data in
            DispatchQueue.main.async {
                Base.shared.userData[0].accessToken = data?.accessToken
                Base.shared.userData[0].refreshToken = data?.refreshToken
            }
        }
        
        ApiManager.shared.updateUser()
        
        
        self.dismiss(animated: true)
    }
}
extension SettingsEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            view().avatarImage.image = selectedImage
            
        }
        if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            view().avatarImage.image = originalImage
        }
        
        picker.dismiss(animated: true)
    }
}
