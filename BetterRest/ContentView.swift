//
//  ContentView.swift
//  BetterRest
//
//  Created by Екатерина Чернова on 04.01.2021.
//

import SwiftUI



struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let cofeeCups = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,16,17 ,18, 19, 20]
    
    
    var body: some View {
        NavigationView {
            
<<<<<<< HEAD
                Section (header: Text("When you want to wake up? main")){
=======
                Section (header: Text("When you want to wake up? kate")){
>>>>>>> kate
//                    Text("When you want to wake up?")
//                        .font(.headline)
                    
                    DatePicker("Please enter your time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                    // .datePickerStyle(WheelDatePickerStyle())
                    
                    VStack(alignment: .leading, spacing: 0){ Text("Desire amount of sleep").font(.headline)
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                        
                        VStack(spacing: 8.0) {
                            
                         Text("Daily coffee intake")
                            .font(.headline)
                        
//                        Stepper(value: $coffeeAmount, in: 1...20) {
//                            if coffeeAmount == 1 {
//                                Text("One cup")
//                            }
//                            else {
//                                Text("\(coffeeAmount) cups")
//                            }
//                        }
                        Picker ("Coffee amount", selection: $coffeeAmount) {
                            ForEach(1 ..< cofeeCups.count) {
                                Text("\(self.cofeeCups[$0])")
                            }
                        }
                        }
                        .padding()
                }
                }
                .padding()
            
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedTime) {
                                        Text("Calculate")
                                    }
            )
            .alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    func calculateBedTime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is ..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem to calculate your bedtime"
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
