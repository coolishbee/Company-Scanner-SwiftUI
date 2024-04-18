//
//  CompanyListCell.swift
//  CompanyScanner
//
//  Created by james on 4/10/24.
//

import SwiftUI

struct CompanyListCell: View {
    
    let company: Company
    
    var body: some View {
        HStack(spacing: 15) {
            
            Image("\(company.img)-Icon")
                .resizable()
                .frame(width: 46, height: 46)
            
            VStack(alignment: .leading) {
                Text(company.name)
                    .foregroundColor(Color.hex("#0C0C0C"))
                    .fontBold(size: 16)
                Text(company.addr)
                    .foregroundColor(Color.black.opacity(0.4))
                    .fontRegular(size: 13)
            }            
            .frame(width: 200, height: 46, alignment: .leading)
            
            Button("Follow".localized(), action: { print("following") })
                .buttonStyle(BookButtonStyle())
                .frame(width: 80, height: 40, alignment: .bottom)
        }
    }
}

//#Preview {
//    CompanyListCell()
//}
