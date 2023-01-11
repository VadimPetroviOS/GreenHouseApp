//
//  Constants.swift
//  GreenHouseApp
//
//  Created by Вадим on 11.01.2023.
//

import UIKit

struct Constants {
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
    
    struct CellIds {
        static let inboxCell = "inboxCell"
        static let logOutCellId: String = "logoutCell"
        static let emailCellId: String = "emailCell"
        static let statusCellId: String = "statusCell"
    }
    
}

