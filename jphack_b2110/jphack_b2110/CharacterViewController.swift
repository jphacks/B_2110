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
    @objc dynamic var nf_calories: Double  = 0
    @objc dynamic var nf_calories_from_fat: Double = 0
    @objc dynamic var nf_total_fat: Double  = 0
    @objc dynamic var nf_saturated_fat: Double  = 0
    @objc dynamic var nf_trans_fatty_acid: Double  = 0
    @objc dynamic var nf_polyunsaturated_fat: Double  = 0
    @objc dynamic var nf_monounsaturated_fat: Double  = 0
    @objc dynamic var nf_cholesterol: Double  = 0
    @objc dynamic var nf_sodium: Double  = 0
    @objc dynamic var nf_total_carbohydrate: Double  = 0
    @objc dynamic var nf_dietary_fiber: Double  = 0
    @objc dynamic var nf_sugars: Double  = 0
    @objc dynamic var nf_protein: Double  = 0
    @objc dynamic var nf_vitamin_a_dv: Double  = 0
    @objc dynamic var nf_vitamin_c_dv: Double  = 0
    @objc dynamic var nf_iron_dv: Double  = 0
    @objc dynamic var nf_serving_weight_grams: Double  = 0
    
}

