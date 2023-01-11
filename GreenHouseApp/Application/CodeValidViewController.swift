//
//  CodeValidViewController.swift
//  
//
//  Created by Вадим on 28.12.2022.
//

import UIKit

class CodeValidViewController: UIViewController {
    var phoneNumber: String
    var responce : Bool?
    var refreshToken: String?
    var accessToken: String?
    
    override func loadView() {
        self.view = CodeValidView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().backgroundColor = Colors.grayBackground
        view().delegate = self
        setupConfig()
    }
    
    func view() -> CodeValidView {
       return self.view as! CodeValidView
    }
    
    func setupConfig() {
        self.view().checkCodeButton.alpha = 0.5
        self.view().checkCodeButton.isEnabled = false
        
        self.view().codeTV.delegate = self
    }
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

extension CodeValidViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 6 {
            self.view().checkCodeButton.alpha = 1
            self.view().checkCodeButton.isEnabled = true
        } else {
            self.view().checkCodeButton.alpha = 0.5
            self.view().checkCodeButton.isEnabled = false
        }
    }
     
}

extension CodeValidViewController: CodeValidViewControllerDelegate  {
    func signUpAction() {
        let code = view().codeTV.text!
        ApiManager.shared.checkAuthCode(number: phoneNumber, authCode: code) { data in
            DispatchQueue.main.async {
                self.responce = data?.isUserExists
                let accessToken = data?.accessToken
                let refreshToken = data?.refreshToken
                let isUserExists = data?.isUserExists
                
                if isUserExists == true {
                    guard let token = accessToken else { return }
                    ApiManager.shared.getCurrentUser(accessToken: token) { data in
                        DispatchQueue.main.async {
                            Base.shared.userData[0].accessToken = accessToken
                            Base.shared.userData[0].refreshToken = refreshToken
                            Base.shared.userData[0].phone = data?.profileData.phone
                            Base.shared.userData[0].name = data?.profileData.name
                            Base.shared.userData[0].username = data?.profileData.username
                            Base.shared.userData[0].city = data?.profileData.city
                            Base.shared.userData[0].birthday = data?.profileData.birthday
                            Base.shared.userData[0].vk = data?.profileData.vk
                            Base.shared.userData[0].instagram = data?.profileData.instagram
                            Base.shared.userData[0].status = data?.profileData.status
                            Base.shared.userData[0].avatar = data?.profileData.avatar
                            
                            let chatVC = ChatTabBarController()
                            self.navigationController?.pushViewController(chatVC, animated: true)
                        }
                    }
                    
                } else {
                    let signUpVC = SignUpViewController(phoneNumber: self.phoneNumber)
                    self.navigationController?.pushViewController(signUpVC, animated: true)
                }
            }
        }
    }
}
