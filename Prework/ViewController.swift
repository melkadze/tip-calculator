//
//  ViewController.swift
//  Prework
//
//  Created by Nick Melkadze on 7/11/22.
//

import UIKit

class ViewController: UIViewController {
    // set up all of our outlets
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
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title in Navigation Bar
        self.title = "Tip Calculator"
        
        // set first responder
        billAmountTextField.becomeFirstResponder()
    }
    
    // unlike viewDidLoad, viewWillAppear also handles loading from the other two view controllers
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
        
        // set slider/segmented control visibility
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
    
    // calculate tip as in the demo case (segmented control)
    @IBAction func calculateTip(_ sender: Any) {
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
        
        // if we need to split the bill, do so
        if (UserDefaults.standard.bool(forKey: "splitting")) {
            splitTotalCostLabel.text = String(format: currency + "%.2f", totalBill / splitControl.value)
        }
        
        // set the label to match current currency
        currencyLabel.text = currency
    }
    
    // handles slider updates, and calculates tip from them
    @IBAction func updateSlider(_ sender: Any) {
        // set the tip percent label
        tipLabel.text = String(Int(tipSlider.value)) + "%"
        
        // Step 1 (calculate tip):
        let initialBill = Float(billAmountTextField.text!) ?? 0 // if the value does not exist, this uses 0
        let tip = initialBill * round(tipSlider.value) / 100
        
        // Step 2 (get total):
        let totalBill = initialBill + tip
        
        // Step 3 (update labels):
        let currency = UserDefaults.standard.string(forKey: "currency") ?? "$"
        // we use %.2f to print 2 decimal places
        tipAmountLabel.text = String(format: currency + "%.2f", tip)
        totalLabel.text = String(format: currency + "%.2f", totalBill)
        
        // if we need to split the bill, do so
        if (UserDefaults.standard.bool(forKey: "splitting")) {
            splitTotalCostLabel.text = String(format: currency + "%.2f", totalBill / Float(splitControl.value))
        }
        
        // set the label to match current currency
        currencyLabel.text = currency
    }
    
    // every time the bill amount changes, update the tip
    @IBAction func billAmountChanged(_ sender: Any) {
        // updates tip using either slider or segmented control based on UserDefaults
        UserDefaults.standard.bool(forKey: "slider") ? updateSlider(UIButton.self) : calculateTip(UIButton.self)
    }
    
    // handle every time the number of people to split between changes
    @IBAction func splitControlUpdated(_ sender: Any) {
        // update the number of people, and make sure to say "person" if it is 1, and "people" in all other cases
        splitNumberLabel.text = "Split bill between " + String(Int(splitControl.value)) + (splitControl.value == 1 ? " person" : " people")
        
        // updates tip using either slider or segmented control based on UserDefaults
        UserDefaults.standard.bool(forKey: "slider") ? updateSlider(UIButton.self) : calculateTip(UIButton.self)
    }
}
