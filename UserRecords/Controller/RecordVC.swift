//
//  RecordVC.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import UIKit

class RecordVC: UIViewController {
    
    var recordData: DataRecord!

    @IBOutlet var daLabel: UILabel!
    @IBOutlet var dmLabel: UILabel!
    @IBOutlet var dataView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataView.layer.cornerRadius = 15
        dataView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        dataView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        daLabel.text = "Date create: \(recordData.da.stringToDate())"
        dmLabel.text = "Date modify: \(recordData.dm.stringToDate())"
        dataView.text = recordData.body
        
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back",
                                                          style: .done,
                                                          target: self,
                                                          action: #selector(backTapped))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc func backTapped(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)     
    }
 
}
