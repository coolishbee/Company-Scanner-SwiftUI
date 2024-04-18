//
//  NetworkingService.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import Foundation
import Combine

class NetworkingService {
    static func fetchCompanyList() -> Future<Data, Error> {
        return Future { promise in
            let companiesData = MockData.companyListData()
            promise(.success(companiesData))
        }
    }
}
