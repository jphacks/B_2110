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
    @IBOutlet weak var ScoreText: UILabel!
    
    // ドキュメントディレクトリの「ファイルURL」（URL型）定義
    var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    // ドキュメントディレクトリの「パス」（String型）定義
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //hiyokoView.loadGif(name: "ikePiyo")
        hiyokoView.loadGif(name: "pochaPiyo")
        
        let User1 = User()
        User1.name = "Test"//追加処理の例
        User1.total_score += 2
        
            let realm = try! Realm()
            try! realm.write{//データベースへの書き込み処理
                realm.add(User1)
              
    }
       // User1.total_score += 2
        ScoreText.text = String(User1.total_score)
}
}

