//
//  lists.swift
//  iOSDecalCustomApp
//
//  Created by Angela Wong on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import Foundation
import UIKit

//will change later, prob not string
var events: [String: [String]] = ["Current Events": [], "Inited To": []]
//

let eventTypes = ["Current Events", "Invited To"]

func getEvent(indexPath: IndexPath) -> String? {
    let eventType = eventTypes[indexPath.section]
    if let event = events[eventType] {
        return event[indexPath.row]
    }
    return nil
    
}

var people : [String: [String]] = ["People to Invite": []]
let pList = ["People To Invite"]

func getPerson(indexPath: IndexPath) -> String? {
    let num = pList[indexPath.section]
    if let person = people[num] {
        return person[indexPath.row]
    }
    return nil
}
