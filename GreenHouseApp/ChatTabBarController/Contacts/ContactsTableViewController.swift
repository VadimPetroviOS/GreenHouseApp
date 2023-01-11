//
//  ContactsTableViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 10.01.2023.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    private let cellId = "ContactsCell"
    let names = ["Татьяна", "Вадим", "Павел"]
    let images = ["https://i.pinimg.com/originals/d6/21/32/d62132b0ad36e694ed39eb8f6f88d278.jpg",
                  "https://avatarko.ru/img/kartinka/17/zhivotnye_sobaka_16861.jpg",
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Agapornis_roseicollis_-Wingham_Wildlife_Park-8.jpg/1200px-Agapornis_roseicollis_-Wingham_Wildlife_Park-8.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    fileprivate func configTableView() {
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactsTableViewCell
        cell.setNameAndImage(name: names[indexPath.row], imageURL: images[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = MessagesViewController()
        navigationController?.pushViewController(chatVC, animated: true)
    }
}

