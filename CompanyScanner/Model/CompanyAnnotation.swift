//
//  CompanyAnnotation.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import Foundation
import MapKit

class CompanyAnnotation: MKPointAnnotation {
    
    let company: Company
    init(company: Company) {
        self.company = company
        super.init()
    }
    
    static func make(from companies: [Company]) -> [CompanyAnnotation] {
        let annotations = companies.map { (company) -> CompanyAnnotation in
            let annotation = CompanyAnnotation(company: company)
            annotation.title = company.name
            annotation.subtitle = company.addr
            annotation.coordinate = CLLocationCoordinate2DMake(company.latitude, company.longitude)
            return annotation
        }
        return annotations
    }
}
