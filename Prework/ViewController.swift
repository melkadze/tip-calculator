//
//  ViewController.swift
//  Prework
//
//  Created by Nick Melkadze on 7/11/22.
//

/// What has been implemented already:
/// Normal tip function
/// Setitngs menu
///

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var splitControl: UIStepper!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var splitTotalCostLabel: UILabel!
    @IBOutlet weak var splitTotalInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set title in Navigation Bar
        self.title = "Tip Calculator"
        
        // set first responder
        billAmountTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // set theme
        switch UserDefaults.standard.integer(forKey: "theme") {
        case 0:
            overrideUserInterfaceStyle = .light
        case 2:
            overrideUserInterfaceStyle = .dark
        default: // case 1, or any other (erraneous) value
            overrideUserInterfaceStyle = .unspecified
        }
        
        // set slider visibility
        if (UserDefaults.standard.bool(forKey: "slider")) {
            tipControl.isHidden = true
            tipLabel.isHidden = false
            tipSlider.isHidden = false
            updateSlider(UIButton.self)
        } else {
            tipControl.isHidden = false
            tipLabel.isHidden = true
            tipSlider.isHidden = true
            calculateTip(UIButton.self)
        }
        
        // set splitting visibility
        if (UserDefaults.standard.bool(forKey: "splitting")) {
            splitControl.isHidden = false
            splitNumberLabel.isHidden = false
            splitTotalInfoLabel.isHidden = false
            splitTotalCostLabel.isHidden = false
        } else {
            splitControl.isHidden = true
            splitNumberLabel.isHidden = true
            splitTotalInfoLabel.isHidden = true
            splitTotalCostLabel.isHidden = true
        }
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        /// Our goals here:
        /// 1. Get initial bill amount, and calculate tip (done)
        /// 2. Calculate total cost (done)
        /// 3. Update tip and total labels (done)
        
        // Step 1 (calculate tip):
        let initialBill = Double(billAmountTextField.text!) ?? 0 // if the value does not exist, this uses 0
        let tipValues = [0.15, 0.18, 0.2]
        let tip = initialBill * tipValues[tipControl.selectedSegmentIndex]
        
        // Step 2 (get total):
        let totalBill = initialBill + tip
        
        // Step 3 (update labels):
        let currency = UserDefaults.standard.string(forKey: "currency") ?? "$"
        // we use %.2f to print 2 decimal places
        tipAmountLabel.text = String(format: currency + "%.2f", tip)
        totalLabel.text = String(format: currency + "%.2f", totalBill)
        
        if (UserDefaults.standard.bool(forKey: "splitting")) {
            splitTotalCostLabel.text = String(format: currency + "%.2f", totalBill / splitControl.value)
        }
    }
    
    @IBAction func updateSlider(_ sender: Any) {
        tipLabel.text = String(Int(tipSlider.value)) + "%"
        
        let initialBill = Float(billAmountTextField.text!) ?? 0 // if the value does not exist, this uses 0
        let tip = initialBill * round(tipSlider.value) / 100
        let totalBill = initialBill + tip
        
        // Step 3 (update labels):
        let currency = UserDefaults.standard.string(forKey: "currency") ?? "$"
        // we use %.2f to print 2 decimal places
        tipAmountLabel.text = String(format: currency + "%.2f", tip)
        totalLabel.text = String(format: currency + "%.2f", totalBill)
        
        if (UserDefaults.standard.bool(forKey: "splitting")) {
            splitTotalCostLabel.text = String(format: currency + "%.2f", totalBill / Float(splitControl.value))
        }
    }
    
    @IBAction func billAmountChanged(_ sender: Any) {
        UserDefaults.standard.bool(forKey: "slider") ? updateSlider(UIButton.self) : calculateTip(UIButton.self)
    }
    
    @IBAction func splitControlUpdated(_ sender: Any) {
        splitNumberLabel.text = "Split bill between " + String(Int(splitControl.value)) + (splitControl.value == 1 ? " person" : " people")
        
        if (UserDefaults.standard.bool(forKey: "slider")) {
            updateSlider(UIButton.self)
        } else {
            calculateTip(UIButton.self)
        }
    }
}
