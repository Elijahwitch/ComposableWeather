import ComposableArchitecture
import Foundation

// MARK: - WeatherClient Definition
struct WeatherClient: Sendable {
    var fetchWeather: @Sendable (String) async throws -> WeatherResponse
    var fetchMultiple: @Sendable ([String]) async throws -> [WeatherResponse]
}
// WeatherClient는 모델 WearherResponse를 UI에 보낼 수 있는 문자열과 비동기 방식으로 받는 두 개의 변수로 정의. 


// MARK: - WeatherClient DependencyKey
extension WeatherClient: DependencyKey {
    static let liveValue: WeatherClient = {
        let fetch: @Sendable (String) async throws -> WeatherResponse = { city in
            let apiKey = "5216bebfb752c543e6fc2511536074c7"
            let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&units=metric&appid=\(apiKey)"
            let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
        }

        let fetchMultiple: @Sendable ([String]) async throws -> [WeatherResponse] = { cities in
            try await withThrowingTaskGroup(of: WeatherResponse.self) { group in
                for city in cities {
                    group.addTask {
                        try await fetch(city) // use the local closure, not liveValue
                    }
                }

                var results: [WeatherResponse] = []
                for try await result in group {
                    results.append(result)
                }
                return results
            }
        }
        
        return WeatherClient(fetchWeather: fetch, fetchMultiple: fetchMultiple)
    }()
}
// MARK: - DependencyValues Extension
extension DependencyValues {
    var weatherClient: WeatherClient {
        get { self[WeatherClient.self] }
        set { self[WeatherClient.self] = newValue }
    }
}

