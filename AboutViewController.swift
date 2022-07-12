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

        // Do any additional setup after loading the view.
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
