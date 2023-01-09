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
        fatalError("")
    }
}

extension SignUpViewController: SignUpViewControllerDelegate  {
    func chatBarAction() {
        let name = view().nameTF.text!
        let username = view().nicknameTF.text!
        
        Base.shared.saveData(phone: phoneNumber,
                             name: name,
                             username: username,
                             city: nil,
                             birthday: nil,
                             vk: nil,
                             instagram: nil,
                             status: nil,
                             filename: nil,
                             base64: nil)
        
        ApiManager.shared.userRegister(number: phoneNumber, name: name, username: username) { (data) in
            DispatchQueue.main.async {
                if data != nil {
                    let chatVC = ChatTabBarController()
                    self.navigationController?.pushViewController(chatVC, animated: true)
                }
            }
            
        }
    }
}
