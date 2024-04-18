//
//  MapViewProtocol.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import Foundation
import MapKit

protocol MapViewProtocol {    
    var viewModel: CompaniesViewModel? { get set }
    func setRegion(_ region: MKCoordinateRegion, needUpdate: Bool, animated: Bool)
}
