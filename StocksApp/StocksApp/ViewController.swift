//
//  ViewController.swift
//  StocksApp
//
//  Created by 18177231 on 01/03/2020.
//  Copyright © 2020 18177231. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
 
    
    
     private let components: [String: String] = ["Apple":"AAPL",
                                                 "Microsoft" : "MSFT",
                                                 "Google":"GOOG",
                                                 "Amazon":"AMZN",
                                                 "Facebook":"FB"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return self.components.keys.count
    }
       
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(self.components.keys)[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companyNameLabel.text = "Tinkoff"
        self.companyPickerView.dataSource = self
        self.companyPickerView.delegate = self

    }
}

