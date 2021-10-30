//
//  GraphViewController.swift
//  jphack_b2110
//
//  Created by Kosuke Rikawa on 2021/10/28.
//

import UIKit
import Foundation
import Charts
import RealmSwift
class GraphViewController: UIViewController {
    

    
    @IBOutlet var linechart: LineChartView!
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    
    var unitsSold = [Int]()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        unitsSold.append(0)
        setLineGraph()
    }

    func setLineGraph(){
        
        // (1)Realmのインスタンスを生成する
        let realm = try! Realm()
        // (2)全データの取得
        let Foods = realm.objects(Food.self)
        // (3)取得データの確認
       // print(Food)
        
        var AllSome : Float = 0

        
        for i in 0 ..< Foods.count {
            AllSome += Foods[i].calories + Foods[i].fat + Foods[i].carbohydrate + Foods[i].protein + Foods[i].vitamin
            unitsSold.append(Int(AllSome))
        }
        
        
        
        var entry = [ChartDataEntry]()
            
        for (i,d) in unitsSold.enumerated(){
            entry.append(ChartDataEntry(x: Double(i),y: Double(d)))
        }
            
        let dataset = LineChartDataSet(entries: entry,label: "Units Sold")
                    
        linechart.data = LineChartData(dataSet: dataset)
        linechart.chartDescription?.text = "栄養のグラフ"
    }
}
