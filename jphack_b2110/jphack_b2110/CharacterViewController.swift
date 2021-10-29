//
//  CharacterViewController.swift
//  jphack_b2110
//
//  Created by siba on 2021/10/24.
//

import Foundation
import RealmSwift


class User: Object {
    @objc dynamic var name:String = ""
    @objc dynamic var total_score: Int16  = 0
    @objc dynamic var Bread: Double  = 0
    @objc dynamic var Dairy: Double = 0
    @objc dynamic var Egg: Double  = 0
    @objc dynamic var Fried: Double  = 0
    @objc dynamic var Meat: Double  = 0
    @objc dynamic var Noodles: Double  = 0
    @objc dynamic var Rice: Double  = 0
    @objc dynamic var Seafood: Double  = 0
    @objc dynamic var Soup: Double  = 0
    @objc dynamic var Vegetable: Double  = 0
}

