//
//  CItyOverviewModel.swift
//  WeatherForecast
//
//  Created by Liz Mabel Gomes on 17/10/23.
//

import Combine
import SwiftUI

final class CityOverviewModel: ObservableObject {
    @Published var lat: Double
    @Published var long: Double
    @Published var name = ""
    @Published var time = ""
    @Published var date = ""
    
    @Published var weatherData: WeatherData?
    @Published var iconURL: URL = URL(string: "https://openweathermap.org/img/wn/10d@2x.png")!
    @Published var temp: String = ""
    @Published var description: String = ""
    @Published var feelslike: String = ""
    @Published var pressure: String = ""
    @Published var humidity: String = ""
    @Published var windSpeed: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f
    }
    
    var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "EEEE, MMMM dd"
        return f
    }

    
    init(city: City) {
        self.lat = city.lat
        self.long = city.lon
        self.name = city.name
        self.time = timeFormatter.string(from: Date())
        self.date = dateFormatter.string(from: Date())
        
        load()
        
    }
    
    func load() {
        WeatherService
            .getWeatherData(lat: lat, long: long)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case.finished: return
                }
            } receiveValue: { [weak self] (weatherData) in
                DispatchQueue.main.async {
                    self?.weatherData = weatherData
                    let icon = weatherData.current?.weather?.first?.icon ?? "10d"
                    self?.iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!
                    self?.temp = "\(weatherData.current?.temp ?? 0.0) °"
                    self?.description = "\(weatherData.current?.weather?.first?.description ?? "")"
                    self?.feelslike = "\(weatherData.current?.feelsLike ?? 0.0)°"
                    self?.pressure = "\(weatherData.current?.pressure ?? 0)"
                    self?.humidity = "\(weatherData.current?.humidity ?? 0)"
                    self?.windSpeed = "\(weatherData.current?.windSpeed ?? 0.0)"
                    
                    print(weatherData)
                }
            }
            .store(in: &cancellables)
    }
}

