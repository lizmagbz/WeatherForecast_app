//
//  Next7DaysView.swift
//  WeatherForecast
//
//  Created by Liz Mabel Gomes on 16/10/23.
//

import SwiftUI

struct Next7DaysView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var forecast: [WeatherData.Daily] = []
    @State var name: String
    
    var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateFormat = "dd.MM."
        return f
    }
    
    var body: some View {
        ScrollView {
    
            nativationBar
    
            Text(name)
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
                .frame(height: 50)
            
            VStack(spacing: 16) {
                ForEach(forecast, id: \.dt) { forecast in
                    DailyForecastView(date: dateFormatter.string(from: forecast.dt ?? Date()), icon: forecast.weather?.first? .icon ?? "10d" , high: "\(forecast.temp?.max ?? 0.0) °", low: "\(forecast.temp?.min ?? 0.0) °")
                }
            }
            .padding()
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.white)
            )
            .padding(.horizontal, 25)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .background(
            Color.cyan
                .opacity(0.2)
                .ignoresSafeArea()
        )
    }
    
    private var nativationBar: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
    }
}
