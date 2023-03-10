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
            createNavControler(viewControler: SettingsViewController(phoneNumber: Base.shared.userData[0].phone,
                                                                     username: Base.shared.userData[0].username,
                                                                     city: Base.shared.userData[0].city,
                                                                     birthday: Base.shared.userData[0].birthday,
                                                                     vk: Base.shared.userData[0].vk,
                                                                     instagram: Base.shared.userData[0].instagram,
                                                                     avatar: Base.shared.userData[0].avatar),
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
}

struct Colors {
    static let grayBackground: UIColor = UIColor(white: 0.9, alpha: 1)
}
