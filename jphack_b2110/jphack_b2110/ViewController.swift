//
//  ViewController.swift
//  jphack_b2110
//
//  Created by Kosuke Rikawa on 2021/10/23.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let User1 = User()
        User1.name = "Test"//追加処理の例
        User1.total_score = 1
        
        do{
            let realm = try Realm()
            try! realm.write{//データベースへの書き込み処理
                realm.add(User1)
            }
        }catch{
            print("Erro..")
        }
    }


}

