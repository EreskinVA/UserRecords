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
        
        recordTextView.backgroundColor = #colorLiteral(red: 0.900935707, green: 0.900935707, blue: 0.900935707, alpha: 1)
        recordTextView.layer.borderWidth = 1
        recordTextView.layer.cornerRadius = 3
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
    
}
