//
//  Color.swift
//  CompanyScanner
//
//  Created by james on 3/30/24.
//

import SwiftUI

extension Color {
    static let bgColor = Color("bgColor")
    static let buttonTextColor = Color("buttonTextColor")
    static let appProfileBlue = Color.hex("#374BFE")    
    
    static let appGray = Color.hex("#0C0C0C").opacity(0.8)
    static let appLightGray = Color.hex("#0C0C0C").opacity(0.4)
    
    static func hex(_ hex: String) -> Color {
        guard let uiColor = UIColor(hex: hex) else {
            return Color.red
        }
        return Color(uiColor)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }

        return nil
    }
}
