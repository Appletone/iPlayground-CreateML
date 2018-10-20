//
//  ViewController.swift
//  TextClassiferDemo
//
//  Created by 07423.louis.chang on 2018/10/15.
//  Copyright © 2018 Louis Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTextView.layer.borderColor = UIColor.gray.cgColor
        myTextView.layer.borderWidth = 0.5
        myTextView.layer.cornerRadius = 5.0
        
        myTextView.delegate = self
    }
}

extension ViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //
        if textView.text == "" {
            myLabel.text = "PTT 偵測器"
            return
        }
        let model = textClassifier()
        do {
            let pred = try model.prediction(text: textView.text)
            
            print(pred.label)
            self.myLabel.text = pred.label
        }
        catch {
            print(error)
        }
    }
}

