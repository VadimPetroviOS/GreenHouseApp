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
                // GET SettingsView
                ApiManager.shared.getCurrentUser(accessToken: accessToken!) { (information) in
                    let username = information?.profileData.username
                    let city = information?.profileData.city
                    let birthday = information?.profileData.birthday
                    let vk = information?.profileData.vk
                    let instagram = information?.profileData.instagram
                    
                    if self.responce == true {
                        let chatVC = ChatTabBarController(phoneNumber: self.phoneNumber,
                                                          username: username,
                                                          city: city,
                                                          birthday: birthday,
                                                          vk: vk,
                                                          instagram: instagram)
                        self.navigationController?.pushViewController(chatVC, animated: true)
                    } else {
                        let signUpVC = SignUpViewController(phoneNumber: self.phoneNumber)
                        self.navigationController?.pushViewController(signUpVC, animated: true)
                    }
                }
                
                
                
            }
        }
        
        
        
    }
}

