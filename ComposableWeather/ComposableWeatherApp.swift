//
//  ComposableWeatherApp.swift
//  ComposableWeather
//
//  Created by Joon Ho Gwak on 5/22/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct ComposableWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(store: Store(initialState: WeatherReducer.State()) {
                WeatherReducer()
                    .dependency(\.weatherClient, .liveValue)
            })
        }
    }
}
