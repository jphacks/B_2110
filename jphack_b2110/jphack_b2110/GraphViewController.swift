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
    let unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 80.0, 50.0, 90.0]
        
    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.addBackground(name:"background3.png")
        setLineGraph()
        //self.view.addSubview(linechart)
    }

    func setLineGraph(){
        var entry = [ChartDataEntry]()
            
        for (i,d) in unitsSold.enumerated(){
            entry.append(ChartDataEntry(x: Double(i),y: d))
        }
            
        let dataset = LineChartDataSet(entries: entry, label: "栄養素")
        linechart.data = LineChartData(dataSet: dataset)
        
        
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
        
    }
    
}
