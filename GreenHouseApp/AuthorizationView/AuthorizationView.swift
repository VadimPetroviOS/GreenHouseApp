//
//  AuthorizationView.swift
//  GreenHouseApp
//
//  Created by Вадим on 28.12.2022.
//

import UIKit

protocol AuthorizationViewControllerDelegate: AnyObject {
    
}

class AuthorizationView: UIView {
    
    weak var delegate: AuthorizationViewControllerDelegate?

    
}
