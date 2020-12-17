//
//  SettingsViewController.swift
//  tip
//
//  Created by Kandarp Ajvalia on 12/14/20.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var settingsView: UIView!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var colorSwitch: UISwitch!

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTipIdx")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        colorSwitch.isOn = defaults.bool(forKey: "isDarkMode")
        setViewColors()
    }

    @IBAction func setDefaultTip(_ sender: Any) {
        
        let selectedTipIdx = tipControl.selectedSegmentIndex
        
        let defaults = UserDefaults.standard
        defaults.set(selectedTipIdx, forKey: "defaultTipIdx")
        
    }

    @IBAction func colorSwitchChange(_ sender: Any) {
        defaults.set(colorSwitch.isOn, forKey: "isDarkMode")
        setViewColors()
    }
    
    func setViewColors() -> Void {
        
        let navBar = navigationController?.navigationBar
        let isDarkMode = defaults.bool(forKey: "isDarkMode")
        
        if isDarkMode {
            navBar?.barTintColor = .black
            navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            settingsView.overrideUserInterfaceStyle = .dark
        } else {
            navBar?.barTintColor = .white
            navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            settingsView.overrideUserInterfaceStyle = .light
        }
    }
}
