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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addTapped))
        
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isConnectedToNetwork()
    }
    
    // MARK: - Table view data source
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewRecord" {
            if let dest = segue.destination as? RecordVC {
                dest.recordData = listRecordsArray[tableView.indexPathForSelectedRow!.row]
            }
        }
        
    }
    
    func isConnectedToNetwork() {
        if Network.isConnectedToNetwork() == true {
            if userSession == nil {
                
                if let session = UserDefaults.standard.string(forKey: "userSession") {
                    userSession = session
                } else {
                    Network.shared.postSession { (session) in
                        UserDefaults.standard.set(session, forKey: "userSession")
                        userSession = session
                        let parameters = "&session=\(userSession!)"
                        Network.shared.postListRecords(parameters: parameters) { (arrayRecords) in
                            self.listRecordsArray = arrayRecords
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                let parameters = "&session=\(userSession!)"
                
                Network.shared.postListRecords(parameters: parameters) { (arrayRecords) in
                    self.listRecordsArray = arrayRecords
                    self.tableView.reloadData()
                }
            }
            
        } else {
            let alert = UIAlertController(title: "Соединение с сетью!",
                                          message: "Проверьте соединение с сетью",
                                          preferredStyle: .alert)
            
            let update = UIAlertAction(title: "Обновить данные",
                                       style: .default)
            { [weak self] _ in
                let parameters = "&session=\(userSession ?? "")"
                
                Network.shared.postListRecords(parameters: parameters) { (arrayRecords) in
                    self!.listRecordsArray = arrayRecords
                    self!.tableView.reloadData()
                }
                
                if let session = UserDefaults.standard.string(forKey: "userSession") {
                    userSession = session
                } else {
                    Network.shared.postSession { (session) in
                        UserDefaults.standard.set(session, forKey: "userSession")
                        userSession = session
                    }
                }
                self?.isConnectedToNetwork()
            }
            
            alert.addAction(update)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func addTapped(sender: AnyObject) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
}
