//
//  ClusterAnnotationView.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import MapKit

class ClusterAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        //displayPriority = .defaultHigh
        //collisionMode = .circle
        //centerOffset = CGPoint(x: 0, y: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let cluster = newValue as? MKClusterAnnotation {
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
                let count = cluster.memberAnnotations.count
                
                image = renderer.image { _ in
                    
                    UIColor.white.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
                    
                    UIColor.systemOrange.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: 38, height: 38)).fill()

                    let fontSize: CGFloat = 15
                    let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
                    let text = "\(count)"
                    let textSize = text.size(withAttributes: attributes)
                    let textRect = CGRect(x: 20 - textSize.width / 2,
                                          y: 20 - textSize.height / 2,
                                          width: textSize.width,
                                          height: textSize.height)
                    text.draw(in: textRect, withAttributes: attributes)
                }
                
            }
        }
        didSet {
            let disclosureButton = UIButton(type: .detailDisclosure)
            disclosureButton.tintColor = UIColor.black
            rightCalloutAccessoryView = disclosureButton
        }
    }
    
    
    
//    private static let annotationSize = 40
//    override var annotation: MKAnnotation? {
//        willSet {
//            guard let clusterAnnotation = newValue as? MKClusterAnnotation else {
//                return
//            }
//
//            let mapAnnotations = clusterAnnotation.memberAnnotations.compactMap { $0 as? CompanyAnnotation }
//            guard let mapAnnotation = mapAnnotations.first else {
//                return
//            }
//
//            collisionMode = .circle
//
//            let size = CGSize(width: Self.annotationSize, height: Self.annotationSize)
//            image = drawGlyph(sized: size, colored: .redMask, withCount: mapAnnotations.count)
//        }
//    }
//
//    private func drawGlyph(sized size: CGSize, colored tintColor: UIColor?, withCount count: Int) -> UIImage {
//        let renderer = UIGraphicsImageRenderer(size: size)
//        return renderer.image { _ in
//            // draw background
//            tintColor?.setFill()
//            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height)).fill()
//
//            if let image = UIImage(systemName: "\(count).circle")?.withTintColor(.yellowMask) {
//                // draw glyph
//                let imageRect = CGRect(x: size.width / 2 - image.size.width / 2,
//                                       y: size.height / 2 - image.size.height / 2,
//                                       width: image.size.width,
//                                       height: image.size.height)
//                image.draw(in: imageRect)
//            } else {
//                // draw text
//                let fontSize: CGFloat = 15
//                let textAttributes: [NSAttributedString.Key: NSObject] = [
//                    NSAttributedString.Key.foregroundColor: UIColor.black,
//                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)
//                ]
//                let text = "\(count)" as NSString
//                let textSize = text.size(withAttributes: textAttributes)
//                let textRect = CGRect(x: 20 - textSize.width / 2,
//                                      y: 20 - textSize.height / 2,
//                                      width: textSize.width,
//                                      height: textSize.height)
//                text.draw(in: textRect, withAttributes: textAttributes)
//            }
//        }
//    }
}

