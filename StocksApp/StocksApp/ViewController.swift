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
    @IBOutlet weak var companySymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
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
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.activityIndicator.startAnimating()
            let selectedSymbol = Array(self.components.values)[row]
            self.requestQuote(for: selectedSymbol)
    }
    
  
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int){
        self.requestQuoteUpdate()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(self.components.keys)[row]
    }

    
    private func requestQuote(for symbol: String){
        let url = URL(string: "https://cloud.iexapis.com/stable/stock/\(symbol)/quote/?token=pk_b33d28f2da774ee88acc8cfd0a114125")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                print("Network error")
                return
            }
            self.parseQuote(data: data)
        }
        dataTask.resume()
    }
    
    private func requestQuoteUpdate(){
        self.activityIndicator.startAnimating()
        self.companyNameLabel.text = "-"
        self.companySymbolLabel.text = "-"
        self.priceLabel.text = "-"
        self.changeLabel.text = "-"
        
        let selectedRow = self.companyPickerView.selectedRow(inComponent: 0)
        let selectedSymbol = Array(self.components.values)[selectedRow]
        self.requestQuote(for: selectedSymbol)
    }
    

    
    private func parseQuote(data: Data){
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String,
                let companySymbol = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let priceChange = json["change"] as? Double

            else{
                print("Invalid JSON format")
                return
            }
            DispatchQueue.main.async {
                self.displayStockInfo(companyName: companyName,
                                      symbol : companySymbol,
                                      price : price,
                                      priceChange : priceChange)
            }
        }
        catch{
            print("JSON parsing error" + error.localizedDescription)
        }
    }
    
    
    private func displayStockInfo(companyName: String ,symbol: String, price: Double,priceChange: Double) {
        self.activityIndicator.stopAnimating()
        self.companyNameLabel.text = companyName
        self.companySymbolLabel.text = symbol
        self.priceLabel.text = "\(price)"
        self.changeLabel.text = "\(priceChange)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companyPickerView.dataSource = self
        self.companyPickerView.delegate = self
        self.activityIndicator.hidesWhenStopped = true
        self.requestQuoteUpdate()
    }
}

