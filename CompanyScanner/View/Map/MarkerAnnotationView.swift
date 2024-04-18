//
//  MarkerAnnotationView.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import Foundation
import MapKit

class MarkerAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
//            guard let companyAnnotation = newValue as? CompanyAnnotation else {
//                return
//            }
            clusteringIdentifier = "companyClusterIdentifier"
            
            glyphImage = UIImage(systemName: "building.2")
            markerTintColor = UIColor.blue
        }
    }
}
