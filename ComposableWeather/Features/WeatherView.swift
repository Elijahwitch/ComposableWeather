//
//  WeatherView.swift
//  ComposableWeather
//
//  Created by Joon Ho Gwak on 5/22/25.
import SwiftUI
import ComposableArchitecture


struct WeatherView: View {

    // The store that holds the state and reducer for the weather feature.
    let store: StoreOf<WeatherReducer>
    
    var body: some View {
        // Connects the view to the store, allowing it to observe state changes and send actions.
        // 뷰를 스토어에 연결해서 상태 변롸와 액션을 관찰하도록.ㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌㅌ
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
                // Display a loading indicator while fetching data.
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

