//
//  SettingsViewController.swift
//  Prework
//
//  Created by Nick Melkadze on 7/11/22.
//

import UIKit

class SettingsViewController: UIViewController {
    // set up all of our outlets
    @IBOutlet weak var themeControl: UISegmentedControl!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var sliderControl: UISwitch!
    @IBOutlet weak var splittingControl: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set nav title and setup the button default values
        self.title = "Settings"
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // send a signal to the main view controller that it will disappear
        // (needed so that leaving this view triggers a viewWillAppear in the main view)
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
        // send a signal to the main view controller that it will appear
        // (needed so that leaving this view triggers a viewWillAppear in the main view)
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    func setupButtons() {
        // currency button:
        // (allows use of it as a drop down and sets the active option)
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
        // (sets the active option)
        switch UserDefaults.standard.integer(forKey: "theme") {
        case 0:
            themeControl.selectedSegmentIndex = 0
        case 2:
            themeControl.selectedSegmentIndex = 2
        default: // case 1, or any other (erraneous) value
            themeControl.selectedSegmentIndex = 1
        }
        
        // slider button:
        // (sets the active option)
        if (UserDefaults.standard.bool(forKey: "slider")) {
            sliderControl.isOn = true
        } else {
            sliderControl.isOn = false
        }
        
        // splitting button:
        // (sets the active option)
        if (UserDefaults.standard.bool(forKey: "splitting")) {
            splittingControl.isOn = true
        } else {
            splittingControl.isOn = false
        }
    }
    
    // sets theme in UserDefaults and handles the animation
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
    
    // sets currency in UserDefaults
    func saveCurrency(value: String) {
        UserDefaults.standard.set(value, forKey: "currency")
        UserDefaults.standard.synchronize()
    }
    
    // sets slider mode in UserDefaults
    @IBAction func sliderModeChanged(_ sender: UISwitch) {
        UserDefaults.standard.set((sliderControl.isOn ? true : false), forKey: "slider")
        UserDefaults.standard.synchronize()
    }
    
    // sets splitting mode in UserDefaults
    @IBAction func splittingModeChanged(_ sender: Any) {
        UserDefaults.standard.set((splittingControl.isOn ? true : false), forKey: "splitting")
        UserDefaults.standard.synchronize()
    }
}
