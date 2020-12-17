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
    @IBOutlet weak var numSplitLabel: UILabel!
    @IBOutlet var tipView: UIView!
    @IBOutlet weak var totalView: UIView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        billAmountTextField.text = getDefaultBill()
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipIdx")
        calculateTipHelper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        billAmountTextField.becomeFirstResponder()
        setViewColors()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        defaults.set(Date(), forKey: "defaultBillTime")
        calculateTipHelper()
    }
    
    func calculateTipHelper() -> Void {
        let bill = Double(billAmountTextField.text!) ?? 0
        defaults.set(bill, forKey: "defaultBill")

        let numSplit = Double(numSplitLabel.text ?? "1")!

        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = (bill + tip) / numSplit
        
        tipPercentageLabel.text = formatBill(total: tip)
        totalLabel.text = formatBill(total: total)
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
        
        let navBar = navigationController?.navigationBar
        let isDarkMode = defaults.bool(forKey: "isDarkMode")
        
        totalView.layer.shadowOpacity = 0.3
        totalView.layer.shadowOffset = CGSize(width: 1, height: 1)
        totalView.layer.shadowRadius = 15.0
        totalView.layer.shadowColor = UIColor.darkGray.cgColor

        if isDarkMode {
            navBar?.barTintColor = .black
            navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            tipView.overrideUserInterfaceStyle = .dark
        } else {
            navBar?.barTintColor = .white
            navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            tipView.overrideUserInterfaceStyle = .light
        }
        
        UISegmentedControl.appearance().setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor(red: 129/255, green: 17/255, blue: 246/255, alpha: 1)], for: .selected)
        
        
    }
    
    func formatBill(total: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formattedBill = formatter.string(from: total as NSNumber) ?? ""
        
        return formattedBill
    }
}
