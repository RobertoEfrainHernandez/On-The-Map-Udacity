//
//  GCDBlackBox.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import Foundation

// MARK: -- Perform Updates to Main Method
/***************************************************************/

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
