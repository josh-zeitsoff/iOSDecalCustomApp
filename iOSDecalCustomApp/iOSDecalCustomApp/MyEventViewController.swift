//
//  MyEventViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit

class MyEventViewController: UIViewController {

    @IBOutlet weak var EventName: UILabel!
    
    @IBOutlet weak var EventLocation: UILabel!
    
    @IBOutlet weak var EventDate: UILabel!
    
    @IBOutlet weak var EventTime: UILabel!
    
    @IBAction func SeeWhosComingButton(_ sender: Any) {
    }
    
    @IBOutlet weak var FractionAttending: UILabel!
    @IBAction func ScanCodesButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
