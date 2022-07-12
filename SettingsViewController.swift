//
//  SettingsViewController.swift
//  Prework
//
//  Created by Nick Melkadze on 7/11/22.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var sliderControl: UISwitch!
    @IBOutlet weak var splittingControl: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set nav title and setup the button default values
        self.title = "Settings"
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentingViewController?.viewWillDisappear(true)
        
        // set theme
        switch UserDefaults.standard.integer(forKey: "theme") {
        case 0:
            overrideUserInterfaceStyle = .light
        case 2:
            overrideUserInterfaceStyle = .dark
        default: // case 1, or any other (erraneous) value
            overrideUserInterfaceStyle = .unspecified
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    func setupButtons() {
        // currency button:
        let currencyOptionClosure = {(action : UIAction) in self.saveCurrency(value: action.title)}
        
        let currency = UserDefaults.standard.string(forKey: "currency")
        
        currencyButton.menu = UIMenu(children : [
            UIAction(title : "$", state : (currency == "$" ? .on : .off), handler: currencyOptionClosure),
            UIAction(title : "£", state : (currency == "£" ? .on : .off), handler: currencyOptionClosure),
            UIAction(title : "€", state : (currency == "€" ? .on : .off), handler: currencyOptionClosure),
            UIAction(title : "₹", state : (currency == "₹" ? .on : .off), handler: currencyOptionClosure),
            UIAction(title : "¥", state : (currency == "¥" ? .on : .off), handler: currencyOptionClosure)])
        
        currencyButton.showsMenuAsPrimaryAction = true
        currencyButton.changesSelectionAsPrimaryAction = true
        
        
        // theme button:
        switch UserDefaults.standard.integer(forKey: "theme") {
        case 0:
            themeControl.selectedSegmentIndex = 0
        case 2:
            themeControl.selectedSegmentIndex = 2
        default: // case 1, or any other (erraneous) value
            themeControl.selectedSegmentIndex = 1
        }
        
        // slider button:
        if (UserDefaults.standard.bool(forKey: "slider")) {
            sliderControl.isOn = true
        } else {
            sliderControl.isOn = false
        }
        
        // splitting button:
        if (UserDefaults.standard.bool(forKey: "splitting")) {
            splittingControl.isOn = true
        } else {
            splittingControl.isOn = false
        }
    }
    
    func saveCurrency(value: String) {
        UserDefaults.standard.set(value, forKey: "currency")
        UserDefaults.standard.synchronize()
    }
    
    var toggleVar = true
    
    @IBAction func setTheme(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(themeControl.selectedSegmentIndex, forKey: "theme")
        UserDefaults.standard.synchronize()
        
        
        if let window = UIApplication.shared.keyWindow {
            UIView.transition (with: window, duration: 0.4, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
                    switch self.themeControl.selectedSegmentIndex {
                    case 0:
                        self.overrideUserInterfaceStyle = .light
                    case 2:
                        self.overrideUserInterfaceStyle = .dark
                    default: // case 1, or any other (erraneous) value
                        self.overrideUserInterfaceStyle = .unspecified
                    }
            }, completion: nil)
        }
    }
    
    @IBAction func sliderModeChanged(_ sender: UISwitch) {
        UserDefaults.standard.set((sliderControl.isOn ? true : false), forKey: "slider")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func splittingModeChanged(_ sender: Any) {
        UserDefaults.standard.set((splittingControl.isOn ? true : false), forKey: "splitting")
        UserDefaults.standard.synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
