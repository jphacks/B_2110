//
//  ViewController.swift
//  jphack_b2110
//
//  Created by Kosuke Rikawa on 2021/10/23.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {

    @IBOutlet weak var hiyokoTalkText: UILabel!
    @IBOutlet weak var hiyokoView: UIImageView!
    
    
    var a = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // (1)Realmのインスタンスを生成する
        let realm = try! Realm()
        // (2)全データの取得
        let Foods = realm.objects(Food.self)
        // (3)取得データの確認
       // print(Food)
        if (Foods.count > 0){
            // 取得件数の表示
            print(Foods.count)
            let bird_status : Float = Foods[Foods.count].calories + Foods[Foods.count].fat + Foods[Foods.count].carbohydrate + Foods[Foods.count].protein + Foods[Foods.count].vitamin
            
            
            if ( bird_status > 100){
                hiyokoView.loadGif(name: "pochaPiyo")
            } else if (bird_status > 50){
                hiyokoView.loadGif(name: "ikePiyo")
            }else{
                hiyokoView.loadGif(name: "yasePiyo")
            }
        }else{
            hiyokoView.loadGif(name: "yasePiyo")
            hiyokoTalkText.text = "おなかすいた！"
        }
        
}
    
    override func viewWillAppear(_ animated: Bool) {//画面に遷移したときに実行される。
        super.viewWillAppear(animated)
        print("viewWillAppear")

        // (1)Realmのインスタンスを生成する
        let realm = try! Realm()
        // (2)全データの取得
        let Foods = realm.objects(Food.self)
        // (3)取得データの確認
       // print(Food)
        if (Foods.count > 0){
            // 取得件数の表示
            print(Foods.count)
            
            //直前の数値から状態を決定する。
            let bird_status : Float = Foods[Foods.count].calories + Foods[Foods.count].fat + Foods[Foods.count].carbohydrate + Foods[Foods.count].protein + Foods[Foods.count].vitamin
            
            
            if ( bird_status > 100){
                hiyokoView.loadGif(name: "pochaPiyo")
                hiyokoTalkText.text = "おなかいっぱい！"
            } else if (bird_status > 50){
                hiyokoView.loadGif(name: "ikePiyo")
                hiyokoTalkText.text = "満足！"
            }else{
                hiyokoView.loadGif(name: "yasePiyo")
                hiyokoTalkText.text = "草足りない!"
            }
        }else{
            hiyokoTalkText.text = "おなかすいた！"
        }
   }
    
    
}

