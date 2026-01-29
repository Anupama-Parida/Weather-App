//
//  DetailedView.swift
//  Weather
//
//  Created by rentamac on 1/23/26.
//

import SwiftUI

struct DetailedView: View {
    @ObservedObject private var vm = WeatherViewModel()
    var location: Location

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Text(location.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top, 30)

                Image(systemName: location.weather.icon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)

                if vm.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {

                    if let temp = vm.temperature {
                        Text("\(Int(temp))°")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    }

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 16
                    ) {

                        WeatherInfoCard(title: "Wind", value: "\(Int(vm.wind)) m/s")
                        WeatherInfoCard(title: "Humidity", value: "\(vm.humidity)%")
                        WeatherInfoCard(title: "Pressure", value: "\(Int(vm.surfacePressure)) hPa")
                        WeatherInfoCard(title: "Precipitation", value: "\(Int(vm.precipitation)) mm")
                    }
                }

                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                Text(
                    "A warm breeze drifted through the streets as the afternoon sun hovered behind a veil of scattered clouds."
                )
                .foregroundColor(.white.opacity(0.8))
                .padding()
            }
            .padding()
        }
        .task {
            await vm.loadWeather(location: location)
        }
    }
}
