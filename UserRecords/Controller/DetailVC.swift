//
//  DetailVC.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet var recordTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save",
                                                          style: .done,
                                                          target: self,
                                                          action: #selector(saveTapped))
        
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    @objc func saveTapped(sender: AnyObject) {

        guard userSession != nil else { return }
        guard recordTextView.text != "", recordTextView.text != nil else { return }
        
        let parameters = "&session=\(userSession!)&body=\(recordTextView.text!)"
        
        Network.shared.postAppendRecord(parameters: parameters)
        
        _ = self.navigationController?.popViewController(animated: true)

    }
    
}
