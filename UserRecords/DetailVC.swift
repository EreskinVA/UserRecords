//
//  DetailVC.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        
        self.navigationItem.rightBarButtonItem = saveButton

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func saveTapped(sender: AnyObject) {
        print("hjxdbsdhjbv")
    }

}
