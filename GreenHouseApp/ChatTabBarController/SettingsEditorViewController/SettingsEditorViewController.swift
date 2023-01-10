//
//  SettingsEditorViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 05.01.2023.
//

import UIKit

class SettingsEditorViewController: UIViewController {
   
    override func loadView() {
        self.view = SettingsEditorView()
    }
    override func viewDidLoad() {
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
        
        Base.shared.userData[0].birthday = view().birthDayTF.text
        Base.shared.userData[0].city = view().cityTF.text
        Base.shared.userData[0].vk = view().vkTF.text
        Base.shared.userData[0].instagram = view().instaTF.text
        
        
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
        
        let image = view().avatarImage.image
        let imageData = image?.jpegData(compressionQuality: 1)
        let imageBase64String = imageData?.base64EncodedString()
        Base.shared.userData[0].status = imageBase64String
        print(Base.shared.userData[0].status)
        
        picker.dismiss(animated: true)
    }
}
