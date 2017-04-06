//
//  SignUpViewController.swift
//  iOSDecalCustomApp
//
//  Created by Cathy Pham Le on 4/4/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var EmailInput: UITextField!
    
    @IBOutlet weak var UserNameSignUpInput: UITextField!
    
    @IBOutlet weak var PasswordSignUpInput: UITextField!
    
    @IBOutlet weak var FirstNameInput: UITextField!
    
    @IBOutlet weak var LastNameInput: UITextField!
    
    @IBAction func RegisterButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
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
