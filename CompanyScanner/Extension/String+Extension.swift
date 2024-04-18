//
//  String+Extension.swift
//  CompanyScanner
//
//  Created by james on 4/11/24.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
