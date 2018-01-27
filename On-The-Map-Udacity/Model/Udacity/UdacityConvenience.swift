//
//  UdacityConvenience.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/20/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation
import UIKit

// MARK: -- Udacity Client (Convenience Methods)
/***************************************************************/

extension UdacityClient {
    
    // MARK: -- Authenticate the User
    /***************************************************************/
    func authenticateUser(username: String, password: String, _ completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        /* Build the URL */
        let urlString = Constants.SessionURL
        let headerFields = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        /* JSON Body */
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        
        /* Make the request */
        let _ = taskForPOSTMethod(urlString: urlString, headerFields: headerFields, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                
                completionHandlerForAuth(false, error.localizedDescription)
            } else {
                if let account = results?[JSONResponseKeys.Account] as? NSDictionary {
                    if let accountKey = account[JSONResponseKeys.AccountKey] as? String{
                        StudentData.accountKey = accountKey
                        completionHandlerForAuth(true, nil)
                    }
                    
                } else {
                    print("Could not find \(JSONResponseKeys.AccountKey) in \(String(describing: results))")
                    completionHandlerForAuth(false, "Invalid Credentials")
                    
                }
            }
        }
    }
    
    // MARK: -- Get the User's Data
    /***************************************************************/
    func getUserData(_ completionHandlerForUserData: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        /* Build the URL */
        let urlString = Constants.UserURL + "/\(StudentData.accountKey)"
        let headerFields = [String:String]()
        
        /* Make the request */
        let _ = taskForGETMethod(urlString: urlString, headerFields: headerFields, client: "udacity") { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error.localizedDescription)
                completionHandlerForUserData(false, "There was an error getting user data.")
            } else {
                if let user = results?[JSONResponseKeys.User] as? NSDictionary {
                    if let userFirstName = user[JSONResponseKeys.firstName] as? String, let userLastName = user[JSONResponseKeys.lastName] as? String {
                        StudentData.firstName = userFirstName
                        StudentData.lastName = userLastName
                        completionHandlerForUserData(true, nil)
                    }
                } else {
                    print("Could not find \(JSONResponseKeys.User) in \(String(describing: results))")
                    completionHandlerForUserData(false,"Could not get the user data.")
                }
            }
        }
    }
    
    // MARK: -- Logout the User
    /***************************************************************/
    func logoutUser(_ completionHandlerForLogoutUser: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        /* Build the URL */
        let urlString = Constants.SessionURL
        let request = NSMutableURLRequest(url:URL(string:urlString)!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        /* Make the request */
        let _ = taskForDELETEMethod(request as URLRequest) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error.localizedDescription)
                completionHandlerForLogoutUser(false, "There was an error with logout.")
            } else {
                if let session = results?[JSONResponseKeys.Session] as? NSDictionary {
                    if let expiration = session[JSONResponseKeys.Expiration] as? String{
                        print("logged out: \(expiration)")
                        completionHandlerForLogoutUser(true, nil)
                    }
                    
                } else {
                    print("Could not find \(JSONResponseKeys.Session) in \(String(describing: results))")
                    completionHandlerForLogoutUser(false, "Could not logout.")
                }
            }
        }
    }
}
