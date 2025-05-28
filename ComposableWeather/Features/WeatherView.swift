//
//  WeatherView.swift
//  ComposableWeather
//
//  Created by Joon Ho Gwak on 5/22/25.
import SwiftUI
import ComposableArchitecture


struct WeatherView: View {
    let store: StoreOf<WeatherReducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                TextField("Enter city", text: viewStore.binding(
                    get: \.city,
                    send: WeatherReducer.Action.cityChanged
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                Button("Get Weather") {
                    viewStore.send(.fetchWeather)
                }
                .disabled(viewStore.city.isEmpty)

                if viewStore.isLoading {
                    ProgressView()
                } else {
                    if let temp = viewStore.temperature, let desc = viewStore.description {
                        Text("Temperature: \(temp)")
                        Text("Description: \(desc)")
                    }

                    if let error = viewStore.errorMessage {
                        Text("Error: \(error)").foregroundColor(.red)
                    }
                }
            }
            .padding()
        }
    }
}

