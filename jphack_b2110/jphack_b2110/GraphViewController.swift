//
//  GraphViewController.swift
//  jphack_b2110
//
//  Created by Kosuke Rikawa on 2021/10/28.
//

import UIKit
import Foundation
import Charts
class GraphViewController: UIViewController {
    
   


   // @IBOutlet var pieGraph: PieChartView!
    
    @IBOutlet var pieGraph: PieChartView!
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //pieGraph.
            setPieCht()
            
            
            
        }
        
    func setPieCht(){
            
            var dataEntries: [ChartDataEntry] = []
     
            for i in 0..<months.count {
                dataEntries.append( PieChartDataEntry(value: unitsSold[i], label: months[i], data: unitsSold[i]))
            }
     
            let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
     
            pieGraph.data = PieChartData(dataSet: pieChartDataSet)
     
            var colors: [UIColor] = []
     
            for _ in 0..<months.count {
                let red = Double(arc4random_uniform(256))
                let green = Double(arc4random_uniform(256))
                let blue = Double(arc4random_uniform(256))
     
                let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
                colors.append(color)
            }
     
            pieChartDataSet.colors = colors
        }
        
    }
