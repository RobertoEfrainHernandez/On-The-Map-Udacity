//
//  ParseStudent.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/20/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation

// Mark: -- Parse (Student Struct)
/***************************************************************/
struct ParseStudent {
    
    // MARK: - Properties
    /***************************************************************/
    var firstName = ""
    var lastName = ""
    var objectID = ""
    var uniqueKey = ""
    var location = ""
    var webURL = ""
    var longitude = 0.0
    var latitude = 0.0
    
    // MARK: - Initializers
    /***************************************************************/
    
    // construct a ParseStudent from a dictionary
    init(dictionary: [String: AnyObject]) {
        if let first = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String {
            firstName = first
        }
        if let last = dictionary[ParseClient.JSONResponseKeys.LastName] as? String {
            lastName = last
        }
        if let objID = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String {
            objectID = objID
        }
        if let uniqKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String {
            uniqueKey = uniqKey
        }
        if let mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String {
            location = mapString
        }
        if let mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String {
            webURL = mediaURL
        }
        if let lon = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double {
            longitude = lon
        }
        if let lat = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double {
            latitude = lat
        }
    }
    
    static func studentsFromResults(_ results: [[String:AnyObject]]) -> [ParseStudent] {
        
        var students = [ParseStudent]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            students.append(ParseStudent(dictionary: result))
        }
        
        return students
    }
        
}
