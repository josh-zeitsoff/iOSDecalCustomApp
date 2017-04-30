//
//  lists.swift
//  iOSDecalCustomApp
//
//  Created by Angela Wong on 4/5/17.
//  Copyright © 2017 Cathy Pham Le. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

//will change later, prob not string
var events: [String: [String]] = ["Current Events": [], "Invited To": []]
//

let eventTypes = ["Current Events", "Invited To"]

func getEvent(indexPath: IndexPath) -> String? {
    let eventType = eventTypes[indexPath.section]
    if let eventsArray = events[eventType] {
        return eventsArray[indexPath.row]
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

func addEvent(date: String, host: String, location: String, username: String) {
    let dbRef = FIRDatabase.database().reference()

    //let path = "\(firStorageImagesPath)/\(UUID().uuidString)"
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let date = dateFormatter.string(from: Date())
    
    let dict: [String:AnyObject] = [
        "date": date as AnyObject,
        "host" : host as AnyObject,
        "invitedPeople" : invitedPeople as [String] as AnyObject,
        "location" : location as AnyObject,
        "username" : username as AnyObject
    ]
    
    dbRef.child(firEventsNode).childByAutoId().setValue(dict)
    // YOUR CODE HERE
}

func getEvents(user: CurrentUser, completion: @escaping ([Event]?) -> Void) {
    let dbRef = FIRDatabase.database().reference()
    var eventArray: [Event] = []
    dbRef.child(firEventsNode).observeSingleEvent(of: .value, with: {
        (snapshot) in
        if snapshot.exists() {
            if let eventsDict = snapshot.value as? [String : AnyObject] {
                user.getInvitedEvents(completion: { (usersInvitedEvents) in
                    for key in eventsDict.keys {
                        //double check only adding invited events
                        if usersInvitedEvents.contains(key) {
                            let username = eventsDict[key]?["username"] as! String
                            let name = eventsDict[key]?["name"] as! String
                            let location = eventsDict[key]?["location"] as! String
                            let host = eventsDict[key]?["host"] as! String
                            let invitedPeople = eventsDict[key]?["invitedPeople"] as! [String]
                            let date = eventsDict[key]?["date"] as! String
                            let event = Event(dateString: date, host: host, invitedPeople: invitedPeople, location: location, name: name, id: key)
                            eventArray.append(event)
                        }
                        
                    }
                    completion(eventArray)
                })
            }
        }
        else {
            completion(nil)
        }
    })
}
