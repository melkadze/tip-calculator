//
//  AboutViewController.swift
//  Prework
//
//  Created by Nick Melkadze on 7/12/22.
//

import UIKit

class AboutViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set theme once everything loads in
        switch UserDefaults.standard.integer(forKey: "theme") {
        case 0:
            overrideUserInterfaceStyle = .light
        case 2:
            overrideUserInterfaceStyle = .dark
        default: // case 1, or any other (erraneous) value
            overrideUserInterfaceStyle = .unspecified
        }
    }
}
