//
//  TimeSelector.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 26/05/24.
//

import SwiftUI

struct TimeSelector: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var drinkHour: Int
    @Binding var drinkMinute: Int
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    
    fileprivate func setTimeNow() {
        let date = Date()
        let calendar = Calendar.current
        hour = calendar.component(.hour, from: date)
        minute = calendar.component(.minute, from: date)
    }
    
    var body: some View {
        VStack() {
            HStack(alignment: .center) {
                Picker(selection: $hour, label: Text("Hour")) {
                    ForEach(0...23, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .frame(width: 85, height: 60)
                
                Picker(selection: $minute, label: Text("Minute")) {
                    ForEach(0...59, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .frame(width: 85, height: 60)
            }
            
            Text(String(format: "%02d:%02d", hour, minute))
            
            HStack {
                Button{
                    setTimeNow()
                } label: {
                    Text("Now")
                }
                
                Button{
                    drinkHour = hour
                    drinkMinute = minute
                    dismiss()
                } label: {
                    Text("Set")
                }
                .background(.orange.opacity(0.7))
                .cornerRadius(100)
            }
            
        }
        .navigationTitle{
            Text("Drink Time")
                .foregroundStyle(.orange)
        }
        .task {
            setTimeNow()
        }
    }
}

#Preview {
    NavigationStack {
        TimeSelector(drinkHour: .constant(0), drinkMinute: .constant(0))
    }
}
