//
//  MapView.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @Binding var annotations: [CompanyAnnotation]?
    var viewModel: CompaniesViewModel?
    
    private let mkMapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        return map
    }()
    
    // MARK: UIViewRepresentable protocol
    func makeUIView(context: Context) -> MKMapView {
        registerAnnotationViewClasses()
        mkMapView.delegate = context.coordinator
        
        let button = MKUserTrackingButton(mapView: mkMapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(button)
        
        let scale = MKScaleView(mapView: mkMapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(scale)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: mkMapView.bottomAnchor, constant: -65),
            button.trailingAnchor.constraint(equalTo: mkMapView.trailingAnchor, constant: -13),
            scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
            scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return mkMapView
    }
    
    // MARK: UIViewRepresentable protocol
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
        guard let annotations = annotations, viewModel?.isRefreshed ?? false else {
            return
        }
        viewModel?.isRefreshed.toggle()
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
    
    // MARK: UIViewRepresentable protocol
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self,
                                   locationManager: CLLocationManager())
    }
    
    func registerAnnotationViewClasses() {
        mkMapView.register(MarkerAnnotationView.self, 
                           forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mkMapView.register(ClusterAnnotationView.self, 
                           forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
        
}

extension MapView : MapViewProtocol {
    
    func setRegion(_ region: MKCoordinateRegion, 
                   needUpdate: Bool,
                   animated: Bool) {
        viewModel?.regionTuple = (region.center.latitude, region.center.longitude)
        if needUpdate {
            mkMapView.setRegion(region, animated: animated)
            viewModel?.requestCompaniesAPI()
        }
    }
}

//struct MapView_Preview: PreviewProvider {
//    static var previews: some View {
//        MapView(annotations: .constant([MKPointAnnotation.example]),
//                viewModel: CompaniesViewModel())
//    }
//}
//
//extension MKPointAnnotation {
//    //static var exampleRegionTuple = (37.559211, 126.835865)
//    static var example: CompanyAnnotation {
//        let testCompany = Company(code: AnyIntValue.int(1),
//                                  name: "게임펍",
//                                  addr: "퀸즈파크나인",
//                                  type: "게임회사",
//                                  lat: AnyDoubleValue.double(37.559211),
//                                  lng: AnyDoubleValue.double(126.835865))
//        let annotation = CompanyAnnotation(company: testCompany)
//        annotation.title = "게임펍"
//        annotation.subtitle = "테스트"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.559211, longitude: 126.835865)
//        return annotation
//    }
//}

