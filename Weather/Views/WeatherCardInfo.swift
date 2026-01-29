//
//  WeatherCardInfo.swift
//  Weather
//
//  Created by rentamac on 1/27/26.
//
import SwiftUI

struct WeatherInfoCard: View {
    let title: String
    let value: String
    var isPrimary: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(isPrimary ? .headline : .caption)
                .foregroundColor(.gray)

            Text(value)
                .font(isPrimary ? .system(size: 36, weight: .bold) : .headline)
                .foregroundColor(.white)
        }
        .frame(
            width: isPrimary ? 200 : 110,
            height: isPrimary ? 120 : 70
        )
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.12))
        )
    }
}
