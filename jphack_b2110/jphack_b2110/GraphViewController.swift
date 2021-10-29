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
    
   


   // @IBOutlet var pieGraph: PieChartView!
    
    @IBOutlet var pieGraph: PieChartView!
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [10.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // (1)Realmのインスタンスを生成する
            let realm = try! Realm()

            // (2)全データの取得
            let results = realm.objects(User.self)

            // (3)取得データの確認
            print(results)
            print(results[0].total_score)
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
