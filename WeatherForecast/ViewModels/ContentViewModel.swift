//
//  ContentViewModel.swift
//  WeatherForecast
//
//  Created by Liz Mabel Gomes on 15/10/23.
//

import Combine
import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var cities = [City]()
    @Published var newCityName = "" 
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        cities = City.placeholder
    }
    
    func addCity() {
        WeatherService
            .getCity(for: newCityName)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case.finished: return
                }
            } receiveValue: { [weak self] (city) in
                DispatchQueue.main.async {
                    self?.cities.append(contentsOf: city)
                }
            }
            .store(in: &cancellables)
    }
}
