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
        view().delegate = self
    }
    
    func view() -> SignUpView {
       return self.view as! SignUpView
    }
    
}

extension SignUpViewController: SignUpViewControllerDelegate  {
    func chatBarAction() {
        let phoneNumber = "+79210497799"
        let name = view().nameTF.text!
        let userName = view().nicknameTF.text!
        ApiManager.shared.userRegister(number: phoneNumber, name: name, userName: userName) { (data) in
            
        }
    }
}


/* 0497799
 {
   "refresh_token": "2724b889-34d5-4410-bb2f-f6c8570a5a7e",
   "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjI3NiwidXNlcm5hbWUiOiJtaXNoYW4iLCJwaG9uZSI6Ijc5MTcwNDk3Nzk5IiwiaWF0IjoxNjcyNzY5NDA4LCJleHAiOjE2NzI3NzAwMDh9.pJRXhzVUpPBkZuaidNMyh47WEF3t5-m5ZlHVvmkg5BA",
   "user_id": 276
 }
 */
