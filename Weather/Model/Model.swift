////
////  model.swift
////  Weather
////
////  Created by rentamac on 1/22/26.
////

import Foundation

struct Location: Identifiable {
    let id: UUID=UUID() 
    let name: String
    let latitude: Double
    let longitude: Double
    let weather: Weather
    let temperature: Temperature
}

enum Weather {
    case sunny
    case foggy
    case snow
    case rainy
    case windy

    var icon: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .foggy:
            return "cloud.fog.fill"
        case .snow:
            return "snowflake"
        case .rainy:
            return "cloud.rain.fill"
        case .windy:
            return "wind"
        }
    }
}

struct Temperature {
    let min: Int
    let max: Int
    
    var temperatureText: String {
        "\(min) °C / \(max) °C"
    }
    var minTemp: String {
       "\(min)°C"
    }
    var maxTemp: String {
        "\(max) °C"
    }
    
}

//final class Model: ObservableObject {
//
//    @Published var searchText: String = ""
//    @Published var locations: [Location] = []
//
//    let dataService = PersistenceController.shared
//
//    init() {
//        getLocations()
//    }
//
//    func getLocations() {
//        locations = dataService.read()
//    }
//}

