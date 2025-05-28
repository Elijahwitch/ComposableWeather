//
//  WetaherResponse.swift
//  ComposableWeather
//
//  Created by Joon Ho Gwak on 5/22/25.
import Foundation

struct WeatherResponse: Decodable, Equatable {
    struct Main: Decodable, Equatable {
        let temp: Double
    }

    struct Weather: Decodable, Equatable {
        let description: String
    }

    let main: Main
    let weather: [Weather]
}
