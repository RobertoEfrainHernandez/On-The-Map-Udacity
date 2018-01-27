//
//  StudentData.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation

// MARK: -- Student Data Model
/***************************************************************/

class StudentData {
    
    static var objectId: String = ""
    static var accountKey: String = ""
    static var firstName: String = ""
    static var lastName: String = ""
    static var mapString: String = ""
    static var mediaURL: String = ""
    static var latitude: Double = 0.0
    static var longitude: Double = 0.0
    
    static var studentLocations = [ParseStudent]()
    
}
