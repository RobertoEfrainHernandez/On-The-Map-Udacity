//
//  UdacityClient.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/20/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation

// MARK: -- Udacity Client
/***************************************************************/

class UdacityClient: Client {
    
    // MARK: - Constants
    /***************************************************************/
    struct Constants {
        static let SessionURL = "https://www.udacity.com/api/session"
        static let UserURL = "https://www.udacity.com/api/users"
    }
    
    // MARK: - Parameter Keys
    /***************************************************************/
    struct ParameterKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: - JSON Response Keys
    /***************************************************************/
    struct JSONResponseKeys {
        
        // Public User Data
        static let User = "user"
        static let firstName = "first_name"
        static let lastName = "last_name"
        
        // Session
        static let Account = "account"
        static let Session = "session"
        static let AccountKey = "key"
        static let Expiration = "expiration"
    }
    
    // MARK: - Shared Instance
    /***************************************************************/
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
}
