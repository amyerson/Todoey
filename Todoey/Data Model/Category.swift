//
//  Category.swift
//  Todoey
//
//  Created by Create the Way on 2/27/18.
//  Copyright © 2018 Favor It. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var categoryBackgroundColor : String = ""
    let items = List<Item>()
}
