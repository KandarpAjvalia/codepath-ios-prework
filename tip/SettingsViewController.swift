//
//  SettingsViewController.swift
//  tip
//
//  Created by Kandarp Ajvalia on 12/14/20.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipIdx")
    }

    @IBAction func setDefaultTip(_ sender: Any) {
        
        let selectedTipIdx = tipControl.selectedSegmentIndex
        
        let defaults = UserDefaults.standard
        defaults.set(selectedTipIdx, forKey: "defaultTipIdx")
        
    }

}
