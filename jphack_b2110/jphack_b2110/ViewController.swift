//
//  ViewController.swift
//  jphack_b2110
//
//  Created by Kosuke Rikawa on 2021/10/23.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {

    @IBOutlet weak var hiyokoView: UIImageView!
    var a = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //hiyokoView.loadGif(name: "ikePiyo")
        
        let User1 = User()
        
        User1.name = "Test"//追加処理の例
        User1.total_score = 1
        User1.nf_calories = 1.0
        User1.nf_calories_from_fat = 1.0
        User1.nf_total_fat = 1.0
        User1.nf_saturated_fat = 1.0
        
            let realm = try! Realm()
            try! realm.write{//データベースへの書き込み処理
                realm.add(User1)
              
    }
        if (a  == 1){
            hiyokoView.loadGif(name: "pochaPiyo")
        } else if (a == 0){
            hiyokoView.loadGif(name: "yasePiyo")
        }else{
            
        }
}
    
    override func viewWillAppear(_ animated: Bool) {//画面に遷移したときに実行される。
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    
}

