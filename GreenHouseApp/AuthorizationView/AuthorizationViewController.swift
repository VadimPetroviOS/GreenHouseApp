//
//  AuthorizationViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 28.12.2022.
//

import UIKit
import FlagPhoneNumber

class AuthorizationViewController: UIViewController, UITextFieldDelegate {

    var listController: FPNCountryListViewController!
    var phoneNumber: String?
    
    override func loadView() {
        self.view = AuthorizationView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
        setupConfig()
    }

    func view() -> AuthorizationView {
       return self.view as! AuthorizationView
    }

    func setupConfig() {
        self.view().nextButton.alpha = 0.5
        self.view().nextButton.isEnabled = false
         
        view().phoneTF.displayMode = .list
        view().phoneTF.delegate = self
        
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: view().phoneTF.countryRepository)
        listController.didSelect = { country in
            self.view().phoneTF.setFlag(countryCode: country.code)
        }
    }
}

extension AuthorizationViewController: FPNTextFieldDelegate {
     
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        ///
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            self.view().nextButton.alpha = 1
            self.view().nextButton.isEnabled = true
            
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            self.view().nextButton.alpha = 0.5
            self.view().nextButton.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Страна"
        view().phoneTF.text = ""
        self.present(navigationController, animated: true)
    }
}

extension AuthorizationViewController: AuthorizationViewControllerDelegate  {
    func codeValidAction() {
        
        ApiManager.shared.sendAuthCode {
            ///
        }
        
        let codeValidVC = CodeValidViewController()
        navigationController?.present(codeValidVC, animated: true)
    }
}

