//
//  ParseConvenience.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/20/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation
import UIKit

// MARK: -- Parse Client (Convenience Methods)
/***************************************************************/

extension ParseClient {
    
    // MARK: -- GET the Student's Location
    /***************************************************************/
    func getStudentLocation(_ completionHandlerForGETStudentLocation: @escaping (_ result: [ParseStudent]?, _ error: NSError?) -> Void) {
        
        /* Parametes */
        let methodParameters = [
            ParameterKeys.Limit : 100,
            ParameterKeys.Order : "-updatedAt"
            ] as [String : Any]
        
        /* Make the request */
        let urlString = Constants.StudentLocationURL + escapedParameters(methodParameters as [String:AnyObject])
        let headerFields = [
            "X-Parse-Application-Id": parseAppID,
            "X-Parse-REST-API-Key": apiKey
        ]
        
        let _ = taskForGETMethod(urlString:urlString, headerFields:headerFields, client:"parse") { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForGETStudentLocation(nil, error)
            } else {
                if let results = results?[JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    // Creates a student object array from results
                    let studentInfo = ParseStudent.studentsFromResults(results)
                    completionHandlerForGETStudentLocation(studentInfo, nil)
                } else {
                    completionHandlerForGETStudentLocation(nil, NSError(domain: "getStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocation"]))
                }
            }
        }
    }
    
    // MARK: -- POST the Student's Location
    /***************************************************************/
    func postStudentLocation(_ completionHandlerForPostStudentLocation: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        /* 1. Build the URL */
        let urlString = Constants.StudentLocationURL
        let headerFields = [
            "X-Parse-Application-Id": parseAppID,
            "X-Parse-REST-API-Key": apiKey,
            "Content-Type": "application/json"
        ]
        
        /* JSON Body */
        let jsonBody = "{\"uniqueKey\": \"\(StudentData.accountKey)\", \"firstName\": \"\(StudentData.firstName)\", \"lastName\": \"\(StudentData.lastName)\",\"mapString\": \"\(StudentData.mapString)\", \"mediaURL\": \"\(StudentData.mediaURL)\",\"latitude\":\(StudentData.latitude), \"longitude\": \(StudentData.longitude)}"
        print(jsonBody)
        
        /* 2. Make the request */
        let _ = taskForPOSTMethod(urlString: urlString, headerFields: headerFields, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostStudentLocation(nil, error)
            } else {
                if let objectId = results?[JSONResponseKeys.ObjectId] as? String {
                    completionHandlerForPostStudentLocation(objectId, nil)
                } else {
                    completionHandlerForPostStudentLocation(nil, NSError(domain: "postNewStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postStudentLocation"]))
                }
            }
        }
    }
}
