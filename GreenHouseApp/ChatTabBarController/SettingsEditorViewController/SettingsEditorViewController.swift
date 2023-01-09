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
    /*
     struct UpdateUser: Codable {
         let name, username, birthday, city: String
         let vk, instagram: String
         let avatar: Avatar
     }

     struct Avatar: Codable {
         let filename, base64: String
     */
    func saveSettings() {
        print(view().cityTF.text!)
        Base.shared.userData[0].birthday = view().birthDayTF.text!
        Base.shared.userData[0].city = view().cityTF.text!
        Base.shared.userData[0].vk = "string"
        Base.shared.userData[0].instagram = "string"
        Base.shared.userData[0].status = "string"
        
        let avatar = Avatar(filename: "string", base64: "string")
        print(avatar)
        let uploadDataModel = UpdateUser(name: Base.shared.userData[0].name ?? "string",
                                         username: Base.shared.userData[0].username ?? "string",
                                         birthday: Base.shared.userData[0].birthday ?? "string",
                                         city: Base.shared.userData[0].city ?? "string",
                                         vk: Base.shared.userData[0].vk ?? "string",
                                         instagram: Base.shared.userData[0].instagram ?? "string",
                                         status: Base.shared.userData[0].status ?? "string",
                                         avatar: avatar)
        print(uploadDataModel)
        ApiManager.shared.updateUser(uploadDataModel: uploadDataModel) { data in
            print("gettokul")
        }
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
