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

/*func addPostToThread(post: Post) {
    threads[post.thread]!.append(post)
}
 */

var people : [String: [String]] = ["People to Invite": []]
let pList = ["People To Invite"]

func getPerson(indexPath: IndexPath) -> String? {
    let num = pList[indexPath.section]
    if let person = people[num] {
        return person[indexPath.row]
    }
    return nil
}

/*
 TODO:
 
 Store the data for a new event in the Firebase database.
 Make sure you understand the hierarchy of the Event tree before attempting to write any data to Firebase!
 Each event node contains the following properties:
 
  - (string) date: the exact date of the event  
  - (string) host: corresponds to the host of the event
 - ([string]) invitedPeople: corresponds to who is invited to this event
 - (string) location: corresponds to the location of the event
  - (string) username: corresponds to the display name of the current user who posted the image.

 Note: Firebase doesn't allow us to store Date objects, so we have to represent the date as a string instead. You can do this by creating a DateFormatter object, setting its dateFormat (check Constants.swift for the correct date format!) and then calling dateFormatter.string(from: Date()).
 
 Create a dictionary with these four properties and store it as a new child under the Events node (you'll need to create a child using an auto ID)
 
 Finally, save the actual data to the storage module by calling the store function below.
 
 Remember, DO NOT USE ACTUAL STRING VALUES WHEN REFERENCING A PATH! YOU SHOULD ONLY USE THE CONSTANTS DEFINED IN CONSTANTS.SWIFT
 
 */

func addEvent(date: String, host: String, invitedPeople: [String], location: String, username: String) {
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

/*
 TODO:
 
 Store the data to the given path on the storage module using the put function.
 You can pass in nil for the metadata.
 In the closure, just check to see if there is an error and print it. You do not need to do anything with the returned metadata.
 
 
func store(data: Data, toPath path: String) {
    let storageRef = FIRStorage.storage().reference()
    storageRef.child(path).put(data, metadata: nil) {
        (metadata, error) in
        if let error = error {
            print(error)
        }
    }
    // YOUR CODE HERE
 }
 */

/*
 TODO:
 
 This function should query Firebase for all Events and return an array of Post objects.
 You should use the function 'observeSingleEvent' (with the 'of' parameter set to .value) to get a snapshot of all of the nodes under "Events".
 If the snapshot exists, store its value as a dictionary of type [String:AnyObject], where the string key corresponds to the ID of each post.
 
 Then, make a query for the user's invited Event ID's. In the completion handler, complete the following:
 - Iterate through each of the keys in the dictionary
 - For each key:
 - Create a new Event object, where Events take in
 dateString, host, invitedPeople, location, name, and id property.
 - Append the new event object to the event array.
 - Finally, call completion(eventArray) to return all of the posts.
 - If any part of the function fails at any point (e.g. snapshot does not exist or snapshot.value is nil), call completion(nil).
 
 Remember to use constants defined in Constants.swift to refer to the correct path!
*/


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
            //make query
            
        }
        else {
            completion(nil)
        }
        //else {
        //completion(nil)
        //}
    })
    
    // YOUR CODE HERE
}
