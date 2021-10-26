//
//  CharacterViewController.swift
//  jphack_b2110
//
//  Created by siba on 2021/10/24.
//

import Foundation
import RealmSwift


class User: Object {
    dynamic var name:String = ""
    dynamic var total_score: Int16  = 0
}
