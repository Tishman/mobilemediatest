//
//  MenuTableViewCell.swift
//  MobileMediaTest
//
//  Created by Роман Тищенко on 23/01/2019.
//  Copyright © 2019 Роман Тищенко. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func updateCell(title: String) {
        menuTitle.text = title
    }
}
