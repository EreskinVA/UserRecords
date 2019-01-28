//
//  ListRecordsUser.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import Foundation

struct DataRecord: Decodable {
    let id: String
    let body: String
    let da: String
    let dm: String
}

struct Record: Decodable {
    var status: Int
    var data: [[DataRecord]]
}
