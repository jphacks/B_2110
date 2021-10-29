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

