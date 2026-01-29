import Foundation
import CoreData

final class PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data load error:", error.localizedDescription)
            }
        }
    }

    // MARK: - Save Context
    private func saveChanges() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Core Data save error:", error.localizedDescription)
            }
        }
    }

    // MARK: - CREATE / UPDATE (UPSERT)
    func saveWeather(
        id: UUID,
        name: String,
        latitude: Double,
        longitude: Double,
        temperature: Double,
        wind: Double,
        pressure: Double,
        humidity: Int,
        precipitation: Double
    ) {
        let context = container.viewContext

        let request: NSFetchRequest<WeatherCache> = WeatherCache.fetchRequest()
        request.predicate = NSPredicate(
            format: "latitude == %lf AND longitude == %lf",
            latitude, longitude
        )
        request.fetchLimit = 1

        let weather = (try? context.fetch(request).first)
            ?? WeatherCache(context: context)

        weather.id = id
        weather.name = name
        weather.latitude = latitude
        weather.longitude = longitude
        weather.temperature = temperature
        weather.wind = wind
        weather.precipitation = precipitation
        weather.humidity = Int16(humidity)
        weather.pressure = pressure
        
        weather.isSynced = true
        weather.updatedAt = Date()

        saveChanges()
    }

    // MARK: - READ
    func fetchAll() -> [WeatherCache] {
        let request: NSFetchRequest<WeatherCache> = WeatherCache.fetchRequest()
        return (try? container.viewContext.fetch(request)) ?? []
    }

    // MARK: - DELETE
    func delete(_ weather: WeatherCache) {
        container.viewContext.delete(weather)
        saveChanges()
    }
    func deleteAllWeatherData() {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherCache")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print(" All Core Data weather records deleted")
        } catch {
            print(" Failed to delete Core Data records:", error.localizedDescription)
        }
    }

}
