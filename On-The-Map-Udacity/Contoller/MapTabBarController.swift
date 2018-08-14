//
//  MapTabBarController.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

// Mark: -- Map Tab Bar Controller
/***************************************************************/

class MapTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

     // MARK: -- Navigation
     /***************************************************************/
    @IBAction func logoutPressed(_ sender: Any) {
        
        /* Logout the User */
        UdacityClient.sharedInstance().logoutUser { (success, errorString) in
            if success {
                performUIUpdatesOnMain {
                    self.dismiss(animated:true,completion:nil)
                }
            } else {
                print(errorString as Any)
            }
        }
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        
        let mapVC = self.viewControllers![0] as! MapViewController
        mapVC.getUserInfo()
    }
    
    @IBAction func addNewLocationPressed(_ sender: Any) {
        
        /* Navigate to the Add New Location Controller */
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewLocation")
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func unwindMapView(segue: UIStoryboardSegue) {}
 
}

