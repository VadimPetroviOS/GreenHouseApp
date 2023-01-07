//
//  ChatTabBarController.swift
//  GreenHouseApp
//
//  Created by Вадим on 04.01.2023.
//

import UIKit

class ChatTabBarController: UITabBarController {
    var phoneNumber: String
    var username: String?
    var city: String?
    var birthday: String?
    var vk: String?
    var instagram: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createNavControler(viewControler: ContactsTableViewController(),
                               title: "Contacts",
                               image: Images.contactsImage,
                               backgroundColor: Colors.grayBackground),
            createNavControler(viewControler: InboxTableViewController(),
                               title: "Chats",
                               image: Images.messagesImage,
                               backgroundColor: Colors.grayBackground),
            createNavControler(viewControler: SettingsViewController(phoneNumber: self.phoneNumber,
                                                                     username: self.username,
                                                                     city: self.city,
                                                                     birthday: self.birthday,
                                                                     vk: self.vk,
                                                                     instagram: self.instagram),
                               title: "Settings",
                               image: Images.settingsImage,
                               backgroundColor: Colors.grayBackground)
        ]
    }
    
    fileprivate func createNavControler(viewControler: UIViewController,
                                        title: String,
                                        image: String, backgroundColor: UIColor) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewControler)
        navController.navigationBar.prefersLargeTitles = true
        viewControler.view.backgroundColor = backgroundColor
        viewControler.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: image)
        return navController
    }
    
    init(phoneNumber: String, username: String?, city: String?, birthday: String?, vk: String?, instagram: String?) {
        self.phoneNumber = phoneNumber
        self.username = username
        self.city = city
        self.birthday = birthday
        self.vk = vk
        self.instagram = instagram
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

struct Images {
    static let messagesImage: String = "bubble.left.and.bubble.right.fill"
    static let contactsImage: String = "person.crop.circle.fill"
    static let settingsImage: String = "gear"
    static let mediaButton: String = "paperclip"
    static let sendButton: String = "arrow.up.circle.fill"
}

struct Colors {
    static let grayBackground: UIColor = UIColor(white: 0.9, alpha: 1)
}
