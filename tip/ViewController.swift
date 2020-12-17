//
//  ViewController.swift
//  tip
//
//  Created by Kandarp Ajvalia on 12/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet var tipView: UIView!
    @IBOutlet weak var numSplitLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        billAmountTextField.text = self.getDefaultBill()
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipIdx")
        self.calculateTipHelper()
        self.billAmountTextField.keyboardType = .decimalPad

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewColors()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        defaults.set(Date(), forKey: "defaultBillTime")
        self.calculateTipHelper()
    }
    
    func calculateTipHelper() -> Void {
        let bill = Double(billAmountTextField.text!) ?? 0
        defaults.set(bill, forKey: "defaultBill")

        let numSplit = Double(numSplitLabel.text ?? "1")!

        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = (bill + tip) / numSplit
        
        tipPercentageLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func subtractSplit(_ sender: Any) {
        let newVal = Int(numSplitLabel.text ?? "1")! - 1
        let labelUpdateVal = newVal >= 1 ? newVal : 1
        numSplitLabel.text = String(labelUpdateVal)
        calculateTipHelper()
    }
    
    @IBAction func addSplit(_ sender: Any) {
        numSplitLabel.text = String(Int(numSplitLabel.text ?? "1")! + 1)
        calculateTipHelper()
    }
    
    func getDefaultBill() -> String {
        let calendar = Calendar.current
        let billTime = (defaults.object(forKey: "defaultBillTime") ?? Date()) as! Date
        let currentTime = Date()
        
        let components = calendar.dateComponents([.minute], from: billTime, to: currentTime)
        if Int(components.minute ?? 0) > 10 {
            defaults.set(0, forKey: "defaultBill")
        }
                
        return String(defaults.double(forKey: "defaultBill"))
    }
    
    func setViewColors() -> Void {
        
        let navBar = self.navigationController?.navigationBar
        let isDarkMode = defaults.bool(forKey: "isDarkMode")
        
        if isDarkMode {
            navBar?.barTintColor = .black
            navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            tipView.overrideUserInterfaceStyle = .dark
        } else {
            navBar?.barTintColor = .white
            navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            tipView.overrideUserInterfaceStyle = .light
        }
    }
}

