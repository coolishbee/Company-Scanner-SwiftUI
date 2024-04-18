//
//  CompanyListView.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import SwiftUI

struct CompanyListView: View {
    @State var companies: [Company]
    @Binding var selectedAnnotation: CompanyAnnotation?
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView(content: {
            ScrollView {
                ForEach(companies) { company in
                    NavigationLink(destination: CompanyDetailView(selectedCompany: company,
                                                                  selectedAnnotation: $selectedAnnotation).navigationBarBackButtonHidden()) {
                        CompanyListCell(company: company)
                    }
                }
            }
            .listStyle(.grouped)
            .navigationBarTitle("CompanyList".localized(), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.buttonTextColor)
            }))
        })
        
    }
}

//#Preview {
//    CompanyListView()
//}
