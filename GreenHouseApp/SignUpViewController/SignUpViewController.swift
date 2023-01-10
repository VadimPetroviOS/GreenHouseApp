//
//  SignUpViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 01.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func loadView() {
        self.view = SignUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().backgroundColor = Colors.grayBackground
        view().delegate = self
        view().phoneLabel.text = "  \(Base.shared.userData[0].phone)"
    }
    
    func view() -> SignUpView {
       return self.view as! SignUpView
    }
}

extension SignUpViewController: SignUpViewControllerDelegate  {
    func chatBarAction() {
        let name = view().nameTF.text!
        let username = view().nicknameTF.text!
        let phone = Base.shared.userData[0].phone
        Base.shared.saveData(accessToken: Base.shared.userData[0].accessToken,
                             refreshToken: Base.shared.userData[0].refreshToken,
                             phone: phone,
                             name: name,
                             username: username,
                             city: nil,
                             birthday: nil,
                             vk: nil,
                             instagram: nil,
                             status: nil,
                             avatar: nil)
        
        ApiManager.shared.userRegister(number: phone, name: name, username: username) { (data) in
            DispatchQueue.main.async {
                if data != nil {
                    let chatVC = ChatTabBarController()
                    self.navigationController?.pushViewController(chatVC, animated: true)
                }
            }
            
        }
    }
}
