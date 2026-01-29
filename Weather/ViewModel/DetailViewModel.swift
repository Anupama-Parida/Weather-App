import Foundation
import Combine

final class WeatherViewModel: ObservableObject {

    @Published var temperature: Double?
    @Published var wind: Double = 0.0
    @Published var humidity: Int = 0
    @Published var surfacePressure: Double = 0
    @Published var precipitation: Double = 0

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol
    
    private let persistence = PersistenceController.shared

    init(
        weatherService: WeatherServiceProtocol = WeatherService(
            networkService: HttpNetworking()
        )
    ) {
        self.weatherService = weatherService
    }

    func loadWeather(location: Location) async {
        print("Started")
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        do {
            print("Fetching weather from API...")

            let response = try await weatherService.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )

            print(" API success — temperature:", response.current.temperature2M)

            // Save to Core Data
            persistence.saveWeather(
                id: location.id,
                name: location.name,
                latitude: location.latitude,
                longitude: location.longitude,
                temperature: response.current.temperature2M,
                wind: response.current.windSpeed10M,
                pressure: response.current.surfacePressure,
                humidity: response.current.relativeHumidity2M,
                precipitation: response.current.precipitation
            )

            // updating ui
            await MainActor.run {
                temperature = response.current.temperature2M
                wind = response.current.windSpeed10M
                humidity = response.current.relativeHumidity2M
                surfacePressure = response.current.surfacePressure
                precipitation = response.current.precipitation
                isLoading = false
            }

            print("UI updated, loading stopped")

        } catch {

            print("API failed — trying Core Data")

            let cached = persistence.fetchAll().first {
                $0.latitude == location.latitude && $0.longitude == location.longitude
            }

            if let cached {
                print(" Loaded from Core Data — temperature:", cached.temperature)
                await MainActor.run {
                    temperature = cached.temperature
                    wind = cached.wind
                    humidity = Int(cached.humidity)
                    surfacePressure = cached.pressure
                    precipitation = cached.precipitation
                    isLoading = false
                }
            } else {
                print("No cached data available")
                await MainActor.run {
                    errorMessage = "Unable to load weather"
                    isLoading = false
                }
            }
        }

        }

    }


