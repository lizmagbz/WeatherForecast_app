//
//  AddCityView.swift
//  WeatherForecast
//
//  Created by Liz Mabel Gomes on 18/10/23.
//

import SwiftUI

struct AddCityView: View {
    @ObservedObject var model: ContentViewModel
    
    var body: some View {
        VStack {
            TextField("New City", text: $model.newCityName)
            
            Button("Add city", action: model.addCity)
        }
        .padding()
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white)
        )
        .padding(.horizontal, 25)
    }
}
