//
//  ViewController.swift
//  MRTTrafficDemo
//
//  Created by Louis.Chang on 2018/10/16.
//  Copyright © 2018 Louis Chang. All rights reserved.
//

import UIKit
import CoreML

class ViewController: UITableViewController {
    var input:MRTInput?
    lazy var model:MRT = {
        return MRT()
    }()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var inboundLabel: UILabel!
    @IBOutlet weak var outboundLabel: UILabel!
    @IBOutlet weak var predLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.input = MRTInput(Date: "2018-10-20", Hour: 15, Inbound: "台北車站", Outbound: "公館")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDate" {
            if let dateVC = segue.destination as? DateViewController {
                dateVC.input = input
            }
        }
        else if segue.identifier == "inboundToList" {
            if let listVC = segue.destination as? StationListTableViewController {
                listVC.type = .inbound
                listVC.input = input
            }
        }
        else if segue.identifier == "outboundToList" {
            if let listVC = segue.destination as? StationListTableViewController {
                listVC.type = .outbound
                listVC.input = input
            }
        }
    }

    func updateViews() {
        guard let input = self.input else {return}
        
        dateLabel.text = "\(input.Date) \(Int(input.Hour)):00"
        inboundLabel.text = input.Inbound
        outboundLabel.text = input.Outbound
    }

    @IBAction func doPredict(_ sender: Any) {
        guard let input = self.input else {return}
        print(input)
        do {
            let pred = try self.model.prediction(input: input)
            let predPassenger = pred.Passenger
            print("預測人次：\(predPassenger)")
            self.predLabel.text = "預測人次：\(Int(predPassenger))"
        }
        catch {
            print(error)
        }
    }
}

struct Constants {
    static let STATION = "動物園,木柵,萬芳社區,萬芳醫院,辛亥,麟光,六張犁,科技大樓,大安,忠孝復興,南京復興,中山國中,松山機場,大直,劍南路,西湖,港墘,文德,內湖,大湖公園,葫洲,東湖,南港軟體園區,南港展覽館,象山,台北101/世貿,信義安和,大安,大安森林公園,東門,中正紀念堂,台大醫院,台北車站,中山,雙連,民權西路,圓山,劍潭,士林,芝山,明德,石牌,唭哩岸,奇岩,北投,新北投,復興崗,忠義,關渡,竹圍,紅樹林,淡水,新店,新店區公所,七張,小碧潭,大坪林,景美,萬隆,公館,台電大樓,古亭,中正紀念堂,小南門,西門,北門,中山,松江南京,南京復興,台北小巨蛋,南京三民,松山,南勢角,景安,永安市場,頂溪,古亭,東門,忠孝新生,松江南京,行天宮,中山國小,民權西路,大橋頭,台北橋,菜寮,三重,先嗇宮,頭前莊,新莊,輔大,丹鳳,迴龍,三重國小,三和國中,徐匯中學,三民高中,蘆洲,頂埔,永寧,土城,海山,亞東醫院,府中,板橋,新埔,江子翠,龍山寺,西門,台北車站,善導寺,忠孝新生,忠孝復興,忠孝敦化,國父紀念館,市政府,永春,後山埤,昆陽,南港,南港展覽館"
    
    static var StationList: [Substring] = {
        return Constants.STATION.split(separator: ",")
    }()
}
