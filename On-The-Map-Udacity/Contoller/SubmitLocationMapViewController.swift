//
//  SubmitLocationMapViewController.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/2/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI

// Mark: -- Submit Location Map View Controller
/***************************************************************/

class SubmitLocationMapViewController: UIViewController, MKMapViewDelegate {
    
    // Mark: - Outlets
    /***************************************************************/
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishedButton: BorderedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        populateMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Annotations
    /***************************************************************/
    private func populateMapView(){
        
        var annotations = [MKPointAnnotation]()
        let lat = CLLocationDegrees(StudentData.latitude)
        let lon = CLLocationDegrees(StudentData.longitude)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(StudentData.firstName) \(StudentData.lastName)"
        annotation.subtitle = StudentData.mediaURL
        annotations.append(annotation)
        
        /* Zoom into a specific region */
        let span = MKCoordinateSpanMake(1, 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        performUIUpdatesOnMain {
            self.mapView.addAnnotations(annotations)
            self.mapView.setRegion(region, animated: true)
            print("New location added to the Map View.")
        }
    }
    
    // MARK: - Go Back to Tab Bar Controller
    /***************************************************************/
    private func backToTabBarView(){
        performUIUpdatesOnMain {
            let alert = UIAlertController(title: "New location Added", message: "Successfully submitted a new location!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                (action) -> Void in
                self.performSegue(withIdentifier: "unwindMapView", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: -- Navigation
    /***************************************************************/
    @IBAction func finishedButtonPressed(_ sender: Any) {
        ParseClient.sharedInstance().postStudentLocation { (results, error) in
            
            if (error != nil) {
                performUIUpdatesOnMain {
                    self.displayAlert(title: "Submission Error", message: "Uable to complete your request")
                    self.dismiss(animated: true, completion: nil)
                }
                print(error)
            } else {
                if let objectId = results {
                    StudentData.objectId = objectId
                    self.backToTabBarView()
                }
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
