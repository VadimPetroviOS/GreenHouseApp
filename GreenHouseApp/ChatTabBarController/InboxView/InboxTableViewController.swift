//
//  InboxTableViewController.swift
//  GreenHouseApp
//
//  Created by Вадим on 04.01.2023.
//

import UIKit

class InboxTableViewController: UITableViewController {
    private let cellId = "InboxCell"
    let names = ["Татьяна", "Вадим"]
    let images = ["https://i.pinimg.com/originals/d6/21/32/d62132b0ad36e694ed39eb8f6f88d278.jpg",
                  "https://avatarko.ru/img/kartinka/17/zhivotnye_sobaka_16861.jpg"]
    let times = ["1m ago", "33m ago"]
    let messages = ["How are you?", "Hello"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    fileprivate func configTableView() {
        tableView.register(InboxCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                 for: indexPath) as! InboxCell
        cell.setNameImageTimeMessages(name: names[indexPath.row],
                              imageURL: images[indexPath.row],
                              time: times[indexPath.row],
                              message: messages[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = MessagesViewController()
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
