//
//  DateViewController.swift
//  MRTTrafficDemo
//
//  Created by Louis.Chang on 2018/10/16.
//  Copyright © 2018 Louis Chang. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    var input:MRTInput?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doSelect(_ sender: UIDatePicker) {
        guard let input = self.input else {return}
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let dfHour = DateFormatter()
        dfHour.dateFormat = "HH"
        
        input.Date = df.string(from: sender.date)
        input.Hour = Double(dfHour.string(from: sender.date)) ?? 0
        
    }

}
