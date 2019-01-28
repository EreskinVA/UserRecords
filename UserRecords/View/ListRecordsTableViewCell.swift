//
//  ListRecordsTableViewCell.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import UIKit

class ListRecordsTableViewCell: UITableViewCell {

    @IBOutlet var da: UILabel!
    @IBOutlet var dm: UILabel!
    @IBOutlet var list: UILabel!
    
    func configure(da: String,
                   dm: String,
                   list: String) {
    
        if da == dm {
            self.dm.isHidden = true
            self.dm.isEnabled = false
        }
        
        self.da.text = da.stringToDate()
        self.dm.text = dm.stringToDate()
        self.list.text = list
    }

}
