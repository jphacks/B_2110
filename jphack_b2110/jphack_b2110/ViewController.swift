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
    
    @IBOutlet weak var AverageText: UILabel!
    
    var a = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BirdStateCheck()
}
    
    override func viewWillAppear(_ animated: Bool) {//画面に遷移したときに実行される。
        super.viewWillAppear(animated)
        print("viewWillAppear")
        BirdStateCheck()
        Eat_Average()

   }
    
    func BirdStateCheck(){
        // (1)Realmのインスタンスを生成する
        let realm = try! Realm()
        // (2)全データの取得
        let Foods = realm.objects(Food.self)
        // (3)取得データの確認
       // print(Food)
        if (Foods.count > 0){
            // 取得件数の表示
            print(Foods[0].date)
            let date2 = Date()
            print(date2)
            print(date2.timeIntervalSince(Foods[0].date))
            //直前の数値から状態を決定する。
            let bird_status : Float = Foods[Foods.count - 1].calories + Foods[Foods.count-1].fat + Foods[Foods.count - 1].carbohydrate + Foods[Foods.count - 1].protein + Foods[Foods.count-1].vitamin
            
            if ( 60*60*4  > date2.timeIntervalSince(Foods[0].date)){
                if ( bird_status > 230){
                    hiyokoView.loadGif(name: "pochaPiyo")
                    hiyokoTalkText.text = "おなかいっぱい！"
                } else if (bird_status > 210){
                    hiyokoView.loadGif(name: "ikePiyo")
                    hiyokoTalkText.text = "満足！"
                }else{
                    hiyokoView.loadGif(name: "yasePiyo")
                    hiyokoTalkText.text = "草足りない!"
                }
            }else if (60*60*8 > date2.timeIntervalSince(Foods[0].date)){
                if ( bird_status > 150){
                    hiyokoView.loadGif(name: "ikePiyo")
                    hiyokoTalkText.text = "満足！"
                }else{
                    hiyokoView.loadGif(name: "yasePiyo")
                    hiyokoTalkText.text = "お腹すいた!"
                }
            }else{
                hiyokoView.loadGif(name: "yasePiyo")
                hiyokoTalkText.text = "おなかすいた！"
            }
        }else{
            hiyokoView.loadGif(name: "yasePiyo")
            hiyokoTalkText.text = "おなかすいた！"
        }
    }
    
    
    func Eat_Average(){
        //全ての結果から平均値を出す
        let realm = try! Realm()
        let Foods = realm.objects(Food.self)
        
        var AllCalories : Float = 0
        var AllFat : Float = 0
        var AllCarbohydrate : Float = 0
        var AllProtein : Float = 0
        var AllVitamin: Float = 0
        
        for i in 0 ..< Foods.count {
            AllCalories += Foods[i].calories
            AllFat += Foods[i].fat
            AllCarbohydrate += Foods[i].carbohydrate
            AllProtein += Foods[i].protein
            AllVitamin  += Foods[i].vitamin
        }
        if (Foods.count > 0){
            var AverageCalories = Int(AllCalories) / Foods.count
            var AverageFat = Int(AllFat) / Foods.count
            var AverageProtein = Int(AllProtein) / Foods.count
            var AverageVitamin = Int(AllVitamin) / Foods.count
            
            AverageText.text = "平均カロリー：\(AverageCalories)kca\n"
        }else{
            var AverageCalories = 0
            var AverageFat = 0
            var AverageProtein = 0
            var AverageVitamin = 0
            
          
            
            
            AverageText.text = "平均カロリー：\(AverageCalories)kcal\n"
            
            
        }
        
       // AverageText.text = "平均値\nビタミン " + AverageCalories + "\n脂質 " + AverageFat + "\nプロテイン " + AverageProtein + "\nビタミン " + AverageVitamin
       
        
    }
}

