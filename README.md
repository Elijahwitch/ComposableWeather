# 🌤️ ComposableWeather

ComposableWeather is a SwiftUI-based weather application built with [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture). It allows users to search for real-time weather data by entering a city name.

---

## 📱 Features

- 🌍 Search for current weather by city name
- 🌡️ Display temperature in Celsius
- ☁️ Show weather condition description
- 🔄 Loading indicator during fetch
- 🧠 Built with TCA for clean, scalable architecture
- ❗ Handles errors (e.g. invalid city or network failure)
- ⚡ Async/Await for API calls

---

## 🧠 Architecture

The app is fully structured with TCA components:

| Component   | Role                                                              |
|-------------|-------------------------------------------------------------------|
| `State`     | Holds the app’s current data (city, temperature, etc.)            |
| `Action`    | Defines user and system-triggered events                          |
| `Reducer`   | Contains pure functions that update state in response to actions |
| `Store`     | Connects state and reducer to SwiftUI views                       |
| `Dependency`| Provides testable external services (`WeatherClient`)             |

---

## 🧪 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/YourUsername/ComposableWeather.git
cd ComposableWeather
````

### 2. Open in Xcode

```bash
open ComposableWeather.xcodeproj
```

### 3. Add OpenWeatherMap API Key

In `WeatherClient.swift`, replace this placeholder:

```swift
let apiKey = "YOUR_API_KEY"
```

with your key from: [https://openweathermap.org/api](https://openweathermap.org/api)

---

## 💡 Example Usage

* Launch the app
* Enter a city like `London`
* Tap **Get Weather**
* View real-time temperature and weather status

---

## 📸 Screenshots

*(You can add UI screenshots here)*

---

## 👷 Author

* **Joon Ho Gwak** ([@Elijahwitch](https://github.com/Elijahwitch))

---

## 📄 License

This project is licensed under the MIT License.
See the [LICENSE](LICENSE) file for details.

---

## 🌐 Credits

* [OpenWeatherMap API](https://openweathermap.org/)
* [TCA by Point-Free](https://github.com/pointfreeco/swift-composable-architecture)


