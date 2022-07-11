//
//  ViewController.swift
//  Prework
//
//  Created by Nick Melkadze on 7/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        // we use %.2f to print 2 decimal places
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", totalBill)
    }
}
