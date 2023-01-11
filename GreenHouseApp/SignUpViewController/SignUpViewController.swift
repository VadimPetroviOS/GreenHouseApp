//
//  SignUpViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 01.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    var phoneNumber: String
    
    override func loadView() {
        self.view = SignUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().backgroundColor = Colors.grayBackground
        view().delegate = self
        view().phoneLabel.text = "  \(phoneNumber)"
    }
    
    func view() -> SignUpView {
       return self.view as! SignUpView
    }
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension SignUpViewController: SignUpViewControllerDelegate  {
    func chatBarAction() {
        let name = view().nameTF.text!
        let username = view().nicknameTF.text!
        let phone = self.phoneNumber
        
        ApiManager.shared.userRegister(number: phone, name: name, username: username) { (data) in
            DispatchQueue.main.async {
                guard let accessToken = data?.accessToken else { return }
                guard let refreshToken = data?.refreshToken else { return }
            
                Base.shared.saveData(accessToken: accessToken,
                                     refreshToken: refreshToken,
                                     phone: self.phoneNumber,
                                     name: name,
                                     username: username,
                                     city: nil,
                                     birthday: nil,
                                     vk: nil,
                                     instagram: nil,
                                     status: nil,
                                     avatar: nil)
                
                let chatVC = ChatTabBarController()
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
        }
    }
}
