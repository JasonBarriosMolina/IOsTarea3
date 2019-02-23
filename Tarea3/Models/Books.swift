//
//  Books.swift
//  Tarea3
//
//  Created by Jason Barrios on 2/21/19.
//  Copyright © 2019 Jason Barrios. All rights reserved.
//

import Foundation
import RealmSwift

class Books : Object {
    
    @objc dynamic var createAt = Date()
    @objc dynamic var title = ""
    @objc dynamic var identifier = NSUUID().uuidString
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
}
