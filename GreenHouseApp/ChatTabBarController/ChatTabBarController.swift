//
//  ChatTabBarController.swift
//  GreenHouseApp
//
//  Created by Вадим on 04.01.2023.
//

import UIKit

class ChatTabBarController: UITabBarController {

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
            createNavControler(viewControler: SettingsViewController(),
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
