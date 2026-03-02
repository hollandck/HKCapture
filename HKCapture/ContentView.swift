//
//  ContentView.swift
//  HKCapture
//
//  Created by Charlie Holland on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = false
    @State var statusText: String = ""
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            }
            Text("Status: \(statusText)")
            Button("Process Workouts") {
                HKManager.instance.parseWorkouts()
                DispatchQueue.main.async {
                    statusText = "Finished Processing"
                }
            }
        }
        .padding()
        .onAppear {
            DispatchQueue.main.async {
                isLoading = true
            }
            statusText = "Loading Workouts"
            HKManager.instance.setup()
            DispatchQueue.main.async {
                statusText = "Finished Loading Workouts"
                isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
