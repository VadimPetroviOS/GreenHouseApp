//
//  AuthorizationViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 28.12.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {

    override func loadView() {
        self.view = AuthorizationView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().delegate = self
    }

    func view() -> AuthorizationView {
       return self.view as! AuthorizationView
    }

}

extension AuthorizationViewController: AuthorizationViewControllerDelegate  {
    
}
