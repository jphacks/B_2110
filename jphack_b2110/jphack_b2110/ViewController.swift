//
//  ViewController.swift
//  jphack_b2110
//
//  Created by Kosuke Rikawa on 2021/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hiyokoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //hiyokoView.loadGif(name: "ikePiyo")
        hiyokoView.loadGif(name: "pochaPiyo")
    }


}

