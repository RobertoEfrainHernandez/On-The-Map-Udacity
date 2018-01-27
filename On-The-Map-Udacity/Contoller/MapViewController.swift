//
//  MapViewController.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import MapKit

// Mark: -- Map View Controller
/***************************************************************/

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // Mark: - Outlets
    /***************************************************************/
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        getUserInfo()
    }


    func getUserInfo() {
        
        ParseClient.sharedInstance().getStudentLocation { (studentInfo, error) in
            if let studentInfo = studentInfo {
                StudentData.studentLocations = studentInfo
                performUIUpdatesOnMain {
                    self.populateMapView()
                }
            }else{
                performUIUpdatesOnMain {
                    self.displayAlert(title: "Invalid URL", message: "Unable to get student locations.")
                }
                print(error)
            }
        }
    }
    
    // Mark: -- Annotations
    /***************************************************************/
    func populateMapView(){
        var annotations = [MKPointAnnotation]()
        for student in StudentData.studentLocations {
            let lat = CLLocationDegrees(student.latitude)
            let long = CLLocationDegrees(student.longitude)
            
            /* The lat and long are used to create a CLLocationCoordinates2D instance */
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            /* Create the annotation and set its coordiate, title, and subtitle properties */
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(student.firstName) \(student.lastName)"
            annotation.subtitle = student.webURL
            /* Place the annotation in an array of annotations */
            annotations.append(annotation)
            
        }
        /* When the array is complete, we add the annotations to the Map View */
        self.mapView.addAnnotations(annotations)
        print("Annotations are now added to the Map View.")
    }
    
    // Mark: -- Map View Data Source
    /***************************************************************/
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            
            let app = UIApplication.shared
            if let annotation = view.annotation, let urlString = annotation.subtitle {
                if let url = URL(string: urlString!) {
                    if app.canOpenURL(url) {
                        app.open(url, options: [:], completionHandler: nil)
                    }else{
                        displayAlert(title: "Invalid URL", message: "Selected URL unable to be opened.")
                    }
                }else{
                    displayAlert(title: "Invalid URL", message: "Not a valid URL.")
                }
            }
        }
    }
}
