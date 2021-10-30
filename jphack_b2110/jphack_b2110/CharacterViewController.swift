//
//  CharacterViewController.swift
//  jphack_b2110
//
//  Created by siba on 2021/10/24.
//

import Foundation
import RealmSwift


class Food: Object {
    @objc dynamic var date:Date = Date()
    @objc dynamic var calories: Float  = 0
    @objc dynamic var fat: Float  = 0
    @objc dynamic var carbohydrate: Float  = 0
    @objc dynamic var protein: Float  = 0
    @objc dynamic var vitamin: Float  = 0
}

