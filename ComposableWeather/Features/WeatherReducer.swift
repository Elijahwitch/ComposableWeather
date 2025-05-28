//  WeatherReducer.swift
//  ComposableWeather
//  Created by Joon Ho Gwak on 5/22/25.
import ComposableArchitecture
import Foundation

@Reducer
struct WeatherReducer {
    
    struct State: Equatable {
        var city: String = ""
        var temperature: String?
        var description: String?
        var isLoading = false
        var errorMessage: String?
    }

    enum Action: Equatable {
        static func == (lhs: WeatherReducer.Action, rhs: WeatherReducer.Action) -> Bool {
            return true
        }
        
        case cityChanged(String)
        case fetchWeather
        case weatherResponse(Result<WeatherResponse, Error>)
    }

    @Dependency(\.weatherClient) var weatherClient

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .cityChanged(city):
            state.city = city
            return .none

        case .fetchWeather:
            state.isLoading = true
            state.errorMessage = nil
            return .run { [city = state.city] send in
                await send(.weatherResponse(Result {
                    try await weatherClient.fetchWeather(city)
                }))
            }

        case let .weatherResponse(.success(response)):
            state.isLoading = false
            state.temperature = "\(response.main.temp) ℃"
            state.description = response.weather.first?.description
            return .none

        case let .weatherResponse(.failure(error)):
            state.isLoading = false
            state.errorMessage = error.localizedDescription
            return .none
        }
    }
}
