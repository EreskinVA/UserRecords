//
//  ListRecordsTVC.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import UIKit

class ListRecordsTVC: UITableViewController {
    
    var listRecordsArray = [DataRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                         target: self,
                                                         action: #selector(addTapped))
        
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard userSession != nil else { return }
        
        let parameters = "&session=\(userSession!)"
        
        Network.shared.postListRecords(parameters: parameters) { (arrayRecords) in
            self.listRecordsArray = arrayRecords
            print(arrayRecords)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRecordsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListRecordsTableViewCell
        
        var body = String(listRecordsArray[indexPath.row].body)
        
        if body.count > 200 {
            body = body.subString(from: 0, to: 200) + "..."
        }
        
        cell.configure(da: listRecordsArray[indexPath.row].da,
                       dm: listRecordsArray[indexPath.row].dm,
                       list: body)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "viewRecord", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewRecord" {
            if let dest = segue.destination as? RecordVC {
                dest.recordData = listRecordsArray[tableView.indexPathForSelectedRow!.row]
            }
        }
        
    }
    
    @objc func addTapped(sender: AnyObject) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
}
