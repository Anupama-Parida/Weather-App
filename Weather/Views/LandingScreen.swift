//
//  ContentView.swift
//  Weather
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ListViewModel()
    private let locations: [(String, Double, Double)] = [
        ("Mumbai", 19.0760, 72.8777),
        ("New Delhi", 28.6139, 77.2090),
        ("Chennai", 13.0827, 80.2707),
        ("Pune", 18.5204, 73.8567),
        ("Bengaluru", 12.9716, 77.5946),
        ("Gurgaon", 28.4595, 77.0266),
        ("Noida", 28.5355, 77.3910),
        ("Hyderabad", 17.3850, 78.4867),
        ("Ahmedabad", 23.0225, 72.5714),
        ("Indore", 22.7196, 75.8577)
    ]
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                    .ignoresSafeArea(edges: .all)
                VStack{
                    Spacer()
                    Image("umbrella")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 20)
                    Text("Breeze")
                        .foregroundColor(.white)
                        .font(.largeTitle.bold())
                    //                    .padding()
                    
                    Text("Weather App")
                        .foregroundColor(.gray)
                    Spacer()
                    NavigationLink{
                        LocationView()
                    }label: {
                        VStack{
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .background(.white)
                                .clipShape(Circle())
                            
                        }.padding(60)
                            .font(.largeTitle)
                    }
                    
                    
                }
            }
            
        }//.onAppear(perform: viewModel.fetchLocations)

    }
}
//private func seedDummyDataIfNeeded() {
//    let db = PersistenceController.shared
//
//    let existingLocations = db.fetchAll()
//    guard existingLocations.isEmpty else {
//        return
//    }
//    let dummyLocations: [(String, Double, Double)] = [
//        ("Mumbai", 19.0760, 72.8777),
//        ("Delhi", 28.6139, 77.2090),
//        ("Pune", 18.5204, 73.8567),
//        ("Bangalore", 12.9716, 77.5946),
//        ("Chennai", 13.0827, 80.2707),
//        ("Kolkata", 22.5726, 88.3639)
//    ]
//
//    // Create weather locations
//    dummyLocations.forEach { name, lat, lon in
//        db.saveWeather(
//            id: UUID(),
//            name: name,
//            latitude: lat,
//            longitude: lon
//        )
//    }
//
//  
//}
//#Preview {
//    ContentView()
//}
