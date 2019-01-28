//
//  Session.swift
//  UserRecords
//
//  Created by Vladimir Ereskin on 28/01/2019.
//  Copyright © 2019 Vladimir Ereskin. All rights reserved.
//

import Foundation

struct SessionId: Decodable {
    let session: String
}

struct Session: Decodable {
    var data: SessionId?
    var status: Int?
}
