//
//  MenuViewController.swift
//  MobileMediaTest
//
//  Created by Роман Тищенко on 23/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.navigationController?.delegate = self
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuTableViewCell
        switch indexPath.row {
        case 0:
            menuCell?.updateCell(title: "Главная")
        case 1:
            menuCell?.updateCell(title: "Первая игра")
        case 2:
            menuCell?.updateCell(title: "Вторая игра")
        default:
            break
        }
        return menuCell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            break
        case 1:            
            let firstGameFolderPath = Bundle.main.path(forResource: "game1", ofType: nil)
            ServerService.gcdWebServer.addGETHandler(forBasePath: "/", directoryPath: firstGameFolderPath!, indexFilename: "index.html", cacheAge: 0, allowRangeRequests: true)
            ServerService.gcdWebServer.start(withPort: 8080, bonjourName: "GCD Web Server")
            self.perform(#selector(showGameVC), with: nil, afterDelay: 1) //Delay for launching WebServer
        case 2:
            let secondGameFolderPath = Bundle.main.path(forResource: "game2", ofType: nil)
            ServerService.gcdWebServer.addGETHandler(forBasePath: "/", directoryPath: secondGameFolderPath!, indexFilename: "index.html", cacheAge: 0, allowRangeRequests: true)
            ServerService.gcdWebServer.start(withPort: 8080, bonjourName: "GCD Web Server")
            self.perform(#selector(showGameVC), with: nil, afterDelay: 1) //Delay for launching WebServer
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func showGameVC() {
        let gameViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
}
