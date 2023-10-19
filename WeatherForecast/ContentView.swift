//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Liz Mabel Gomes on 15/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = ContentViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                AddCityView(model: model)
                ForEach(model.cities) { city in
                    CityOverview(city: city)
                }

            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .navigationBarHidden(true)
            .background(
                Color.cyan
                    .opacity(0.2)
                    .ignoresSafeArea()
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
