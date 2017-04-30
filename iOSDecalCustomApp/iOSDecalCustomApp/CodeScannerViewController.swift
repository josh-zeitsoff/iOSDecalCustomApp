//
//  CodeScannerViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase
import SwiftQRCode

class CodeScannerViewController: UIViewController {
    
    let scanner = QRCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
            // THIS IS WHERE YOU WOULD AUTHENTICATE THE QR CODE
            self.performSegue(withIdentifier: "unwindToMyEvent", sender: self)
        }
        scanner.scanFrame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // start scan
        scanner.startScan()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
