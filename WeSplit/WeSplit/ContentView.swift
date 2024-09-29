//
//  ContentView.swift
//  WeSplit
//
//  Created by Zheen Suseyi on 9/28/24.
//

/* This project was the first project included in the 100 days of SwiftUI tutorial! Previously, it was just challenge problems using Swift Playgrounds. Most of the code was given by the tutorial except for the 3 challenges that were given below. That is my own code!
*/

/*
 CHALLENGE:
 Add a header to the third section, saying “Amount per person”
 Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
 Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
 */

import SwiftUI

struct ContentView: View {
    
    // Initializing our variables
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = Array(1...100)

    // Computed property to calculate the total per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    // Computed property to calculate the total bill after tip
    var totalCheckAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        
        // Wrapping everything in a navigation stack so that we can navigate screens
        NavigationStack {
            Form {
                
                // Top of the screen, amount section
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    // Right below, a picker that lets the user select how many people were at the table
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                    // Directs the user to another screen once they click on Number of People
                    .pickerStyle(.navigationLink)
                    
                    // WeSplit Title at the very top
                    .navigationTitle("WeSplit")
                    
                    // Done button top right when focused on entering the cost of the food pre tip
                    .toolbar {
                        if amountIsFocused {
                            Button("Done") {
                                amountIsFocused = false
                            }
                        }
                    }
                }
                
                // 2nd section that will ask for the tip percentage
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    
                    // Takes the user to a seperate screen
                    .pickerStyle(.navigationLink)
                }
                
                // Third section that gives the total per person
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                } /* Amount per person header title */ header: {
                    Text("Amount per person")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                
                // Last section which will be the total amount calculated
                Section {
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                } /* total amount header title */ header: {
                    Text("Total Amount!")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
