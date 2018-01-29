//
//  MapTableViewController.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

// Mark: -- Map Table View Controller
/***************************************************************/

class MapTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // Mark: -- Table View Data Source
    /***************************************************************/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of student locations: \(StudentData.studentLocations.count)")
        return StudentData.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "studentCell"
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellID) as! MapTableViewCell
        let student = StudentData.studentLocations[(indexPath as NSIndexPath).row]
        cell.studentNameLabel.text = "\(student.firstName) \(student.lastName)"
        cell.studentURLLabel.text = "\(student.webURL)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = StudentData.studentLocations[indexPath.row]
        if let url = URL(string: selectedCell.webURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                performUIUpdatesOnMain {
                    self.displayAlert(title: "Invalid URL", message: "Selected URL unable be opened.")
                }
            }
        }else{
            performUIUpdatesOnMain {
                self.displayAlert(title: "Invalid URL", message: "Not a valid URL.")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /* Delete Feature */
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            StudentData.studentLocations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(StudentData.studentLocations)
        }
    
        return [delete]
        
    }

}

