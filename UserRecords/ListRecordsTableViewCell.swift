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
    
    func configure(da: String, dm: String, list: String) {
        self.da.text = da
        self.dm.text = dm
        self.list.text = list
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
