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
    @objc dynamic var lastEatTime:String = ""
    @objc dynamic var total_score: Int16  = 0
    //最後に食べた時間の保持 多分stringにして保持するのが丸い
    //@objc dynamic var last_eat_time:String = ""
    //@objc dynamic var documentDirectoryFileURL
    //= FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

