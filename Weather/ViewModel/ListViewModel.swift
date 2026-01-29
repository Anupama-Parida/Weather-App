//
//  ListViewModel.swift
//  Weather
//
//  Created by rentamac on 1/22/26.
//

import Combine
import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var location: [Location] = [
        Location(
            name: "Mumbai",
            latitude: 19.0760,
            longitude: 72.8777,
            weather: .sunny,
            temperature: Temperature(min: 22, max: 32)
        ),
        Location(
            name: "Delhi",
            latitude: 28.7041,
            longitude: 77.1025,
            weather: .foggy,
            temperature: Temperature(min: 11, max: 24)
        ),
        Location(
            name: "Chennai",
            latitude: 13.0827,
            longitude: 80.2707,
            weather: .sunny,
            temperature: Temperature(min: 24, max: 36)
        ),
        Location(
            name: "Pune",
            latitude: 18.5204,
            longitude: 73.8567,
            weather: .sunny,
            temperature: Temperature(min: 22, max: 32)
        ),
        Location(
            name: "Bengaluru",
            latitude: 12.9716,
            longitude: 77.5946,
            weather: .rainy,
            temperature: Temperature(min: 24, max: 30)
        ),
        Location(
            name: "Gurgaon",
            latitude: 28.4595,
            longitude: 77.0266,
            weather: .foggy,
            temperature: Temperature(min: 11, max: 23)
        ),
        Location(
            name: "Noida",
            latitude: 28.5355,
            longitude: 77.3910,
            weather: .snow,
            temperature: Temperature(min: 9, max: 22)
        ),
        Location(
            name: "Hyderabad",
            latitude: 17.3850,
            longitude: 78.4867,
            weather: .windy,
            temperature: Temperature(min: 22, max: 32)
        ),
        Location(
            name: "Ahemedabad",
            latitude: 23.0225,
            longitude: 72.5714,
            weather: .sunny,
            temperature: Temperature(min: 20, max: 32)
        ),
        Location(
            name: "Indore",
            latitude: 22.7196,
            longitude: 75.8577,
            weather: .sunny,
            temperature: Temperature(min: 18, max: 24)
        )
    ]

    var filteredlocation : [Location]{
        if searchText.isEmpty{
            return location
        }
        else{
            return location.filter({$0.name.contains(searchText)})
        }
    }
}
