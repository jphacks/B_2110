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

    //let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
   // let unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 80.0, 50.0, 90.0]

    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    
    var unitsSold = [Int]()
    
        
    override func viewDidLoad() {

        super.viewDidLoad()

       // self.view.addBackground(name:"background3.png")

        unitsSold.append(0)
       setLineGraph()
        //self.view.addSubview(linechart)
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
            
        let dataset = LineChartDataSet(entries: entry, label: "栄養素")
        linechart.data = LineChartData(dataSet: dataset)
            
        /*
        // X軸のラベルの位置を下に設定
        linechart.xAxis.labelPosition = .bottom
        // X軸のラベルの色を設定
        linechart.xAxis.labelTextColor = .systemGray
        dataset.circleColors = [UIColor.gray]
        dataset.lineWidth = 5
        //linechart.chartDescription?.text = "Item Sold Chart"
        linechart.borderLineWidth = 20.0
        linechart.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        linechart.leftAxis.drawAxisLineEnabled = true
        // 右側のY座標軸は非表示にする
        linechart.rightAxis.enabled = false
        //x軸のグリッドを非表示
        linechart.xAxis.drawGridLinesEnabled = false
        // Y座標の値が0始まりになるように設定
        linechart.leftAxis.axisMinimum = 0.0
        linechart.leftAxis.axisMaximum = 100
        linechart.leftAxis.drawZeroLineEnabled = true
        linechart.leftAxis.zeroLineColor = .systemGray
        // X座標の値が0始まりになるように設定
        linechart.xAxis.axisMinimum = 1.0
        linechart.xAxis.axisMaximum = 7.0
        //グラフのアニメーション(秒数で設定)
        linechart.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .easeInOutElastic)
        
         */
        linechart.chartDescription?.text = "栄養のグラフ"

    }
    
}
