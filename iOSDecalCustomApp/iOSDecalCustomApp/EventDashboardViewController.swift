//
//  EventDashboardViewController.swift
//  iOSDecalCustomApp
//
//  Created by Joshua Zeitsoff on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import UIKit
import Firebase

class EventDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var EventDashboardTableView: UITableView!
    @IBAction func CreateEventButton(_ sender: Any) {
        performSegue(withIdentifier: "dashToCreateEvent", sender: nil)
    }
    
    @IBAction func unwindToDash(segue:UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventTypes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventTypes[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let deats = eventTypes[section]
        return events[deats]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashCell", for: indexPath) as! EventDashboardTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let deats = getEvent(indexPath: indexPath) {
            let eventType = eventTypes[indexPath.section]
            if eventType == "Current Events" {
                performSegue(withIdentifier: "dashToMyEvent", sender: self)
            } else if eventType == "Invited To" {
                performSegue(withIdentifier: "dashToQREvent", sender: self)
            }
        }
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
