import Foundation
import CoreLocation

// Hava durumu veri modeli
public struct WeatherData {
    public let locationName: String
    public let temperature: Double
    public let feelsLike: Double
    public let description: String
    
    public init(locationName: String, temperature: Double, feelsLike: Double, description: String) {
        self.locationName = locationName
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.description = description
    }
}

// Hata tipleri
public enum WeatherError: Error {
    case invalidURL
    case noData
    case networkError
    case parsingError
}

// Ana hava durumu servisi
public class WeatherService {
    
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func getWeather(for coordinate: CLLocationCoordinate2D,
                          completion: @escaping (Result<WeatherData, WeatherError>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric&lang=en"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    var locationName = "Unknown"
                    var temperature = 0.0
                    var feelsLike = 0.0
                    var description = "No description"
                    
                    // Şehir ismi
                    if let name = json["name"] as? String {
                        locationName = name
                    }
                    
                    // Sıcaklık bilgileri
                    if let main = json["main"] as? [String: Any] {
                        if let temp = main["temp"] as? Double {
                            temperature = temp
                        }
                        if let feels = main["feels_like"] as? Double {
                            feelsLike = feels
                        }
                    }
                    
                    // Hava durumu açıklaması
                    if let weatherArray = json["weather"] as? [[String: Any]],
                       let firstWeather = weatherArray.first,
                       let desc = firstWeather["description"] as? String {
                        description = desc
                    }
                    
                    let weatherData = WeatherData(
                        locationName: locationName,
                        temperature: temperature,
                        feelsLike: feelsLike,
                        description: description
                    )
                    
                    completion(.success(weatherData))
                }
            } catch {
                completion(.failure(.parsingError))
            }
        }
        
        task.resume()
    }
}
