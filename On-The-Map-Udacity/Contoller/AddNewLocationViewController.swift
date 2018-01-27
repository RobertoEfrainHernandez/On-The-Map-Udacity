//
//  AddNewLocationViewController.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBookUI

// Mark: -- Add New Location View Controller
/***************************************************************/

class AddNewLocationViewController: UIViewController, UITextFieldDelegate {

    // Mark: - Outlets
    /***************************************************************/
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var findLocationButton: BorderedButton!
    
    // Mark: - Properties
    /***************************************************************/
    var address = ""
    var mediaURL = ""
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationTextField.delegate = self
        urlTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    

    
    // MARK: -- Navigation
    /***************************************************************/
    @IBAction func findLocationPressed(_ sender: Any) {
        /* Check if Text Fields are Empty */
        if locationTextField.text!.isEmpty{
            displayAlert(title: "Location Text Field Empty", message: "You must enter your Location")
        }else if urlTextField.text!.isEmpty{
            displayAlert(title: "URL Text Field Empty", message: "You must enter a Website")
        }else{
            address = locationTextField.text!
            StudentData.mapString = locationTextField.text!
            StudentData.mediaURL = urlTextField.text!
            forwardGeocoding(address)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: -- Geolocation Helper Methods
    /***************************************************************/
    func forwardGeocoding(_ address: String) {
        showActivityIndicator(activityIndicator)
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        guard (error == nil) else {
            print("Unable to Forward Geocode Address (\(String(describing: error)))")
            displayAlert(title: "Geocode Error", message: "Unable to Forward Geocode Address")
            return
        }
        
        if let placemarks = placemarks, placemarks.count > 0 {
            let placemark = placemarks[0]
            if let location = placemark.location {
                let coordinate = location.coordinate
                print("*** coordinate ***")
                print(placemark)
                
                StudentData.latitude = coordinate.latitude
                StudentData.longitude = coordinate.longitude
                
                if (placemark.locality != nil && placemark.administrativeArea != nil){
                    StudentData.mapString = ("\(placemark.locality!),\(placemark.administrativeArea!)")
                }
                presentSubmitLocationView()
            } else {
                displayAlert(title: "User Data", message: "No Matching Location Found")
            }
        }
    }
    
    func getUserName(){
        UdacityClient.sharedInstance().getUserData { (success, errorString) in
            guard (errorString == nil) else{
                performUIUpdatesOnMain {
                    self.displayAlert(title: "User Data", message: errorString)
                }
                return
            }
        }
    }
    
    private func presentSubmitLocationView(){
        self.hideActivityIndicator(self.activityIndicator)
        performSegue(withIdentifier: "submitNewLocation", sender: self)
    }
    
    // MARK: -- TextField Helper
    /***************************************************************/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
