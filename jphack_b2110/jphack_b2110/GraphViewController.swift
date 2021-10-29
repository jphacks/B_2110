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
    let unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 80.0]
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setLineGraph()
    }

    func setLineGraph(){
        var entry = [ChartDataEntry]()
            
        for (i,d) in unitsSold.enumerated(){
            entry.append(ChartDataEntry(x: Double(i),y: d))
        }
            
        let dataset = LineChartDataSet(entries: entry,label: "Units Sold")
                    
        linechart.data = LineChartData(dataSet: dataset)
        linechart.chartDescription?.text = "Item Sold Chart"
    }
}
