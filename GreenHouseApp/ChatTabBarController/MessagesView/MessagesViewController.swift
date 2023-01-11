//
//  MessagesViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 11.01.2023.
//

import UIKit

class MessagesViewController: UIViewController {
    
    override func loadView() {
        self.view = MessagesView()
    }
    
    override func viewDidLoad() {
        // Не успел сделать всплывающую клавиатуру
        super.viewDidLoad()
        view().backgroundColor = Constants.Colors.grayBackground
        tabBarController?.tabBar.isHidden = true
        
    }
    
    fileprivate func view() -> MessagesView {
        return self.view as? MessagesView ?? MessagesView()
    }
}
