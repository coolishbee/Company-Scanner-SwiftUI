//
//  ContentView.swift
//  CompanyScanner
//
//  Created by james on 3/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = CompaniesViewModel()
    
    @State var isDetailPresented = false
    
    var body: some View {
        ZStack {
            MapView(annotations: $viewModel.annotiations, viewModel: viewModel)
                .alert(isPresented: $viewModel.showMapAlert) {
                    Alert(title: Text("Location access denied"),
                          message: Text("Your location is needed"),
                          primaryButton: .cancel(),
                          secondaryButton: .default(Text("Settings"),
                                                    action: { self.openDeviceSettings() }))
            }.edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .bottom) {
                if viewModel.isSelectedAnnotation {
                    BottomSheetView(jobs: (self.viewModel.selectedCompany?.jobs)!,
                                    selectedAnnotation: $viewModel.selectedAnnotation,
                                    isPresented: $isDetailPresented).onDisappear() {
                        self.viewModel.selectedAnnotation = nil
                    }
                    .padding(.top, 600)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .animation(.interactiveSpring(), value: viewModel.isSelectedAnnotation)
            .fullScreenCover(isPresented: $isDetailPresented) {
                CompanyDetailView(selectedCompany: viewModel.selectedCompany,
                                  selectedAnnotation: $viewModel.selectedAnnotation).onDisappear() {
                    print("onDisappear!!!")
                }
            }
                        
        }
        .fullScreenCover(isPresented: $viewModel.isSelectedAnnotations) {
            CompanyListView(companies: viewModel.selectedCompanies,
                            selectedAnnotation: $viewModel.selectedAnnotation).onDisappear() {
                print("onDisappear!!!")
            }
        }

    }
}

//#Preview {
//    ContentView()
//}

extension ContentView {
    func openDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func clearSelectedAnnotation() {
        self.viewModel.selectedAnnotation = nil
        self.viewModel.selectedAnnotations = nil
    }
}
