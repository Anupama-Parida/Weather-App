//
//  LocationView.swift
//  Weather
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

struct LocationView: View {

    @StateObject var viewModel: ListViewModel = ListViewModel()
    @ObservedObject private var vm = WeatherViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .ignoresSafeArea()

                VStack {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.6))
                    
                        TextField("Search", text: $viewModel.searchText)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                            .padding(10)
                    }
                    
                    .padding(.horizontal, 14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.35), lineWidth: 1)
                    )
                    .padding(.leading, 20)
                    .padding(.trailing, 30)
//                    Spacer()
                    List {
                        ForEach(viewModel.filteredlocation) { location in

                            NavigationLink {
                                DetailedView(location: location)
                            } label: {
                                HStack {

                                    Text(location.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 25))

                                    Spacer()
                                    
                                    VStack{
                                        Image(systemName: location.weather.icon)
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 24))
                                        
//                                        Spacer()
//                                        Text(location.temperature.min == 0
//                                             ? "--" : "\(location.temperature.min)°C")
//                                            .foregroundColor(Color.white)
//                                            .font(.system(size: 15))
                                    }
                               

                                }
//                                                )
                                    .background(Color.clear)
                              
                            }.listRowBackground(Color.clear)
                                .frame(height: 45)
                                
                        }
                    }.scrollContentBackground(.hidden)

                }

            }//.navigationTitle("Locations").foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Locations")
                        .foregroundColor(.white)
                }
            }
            Button("Clear Cache") {
                PersistenceController.shared.deleteAllWeatherData()
            }
        }
    }
}

#Preview {
    LocationView()
}
