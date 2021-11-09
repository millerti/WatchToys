//
//  ContentView.swift
//  WatchToys WatchKit Extension
//
//  Created by Tim Miller on 11/7/21.
//

import SwiftUI

struct ContentView: View {
    var model: WatchToysVM = WatchToysVM()
    
    var body: some View {
        VStack {
            Text("WatchToys needs your permission to read Steps data from HealthKit.")
                .padding()
            Button("Authorize", action: model.AuthorizeStepsData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    var model: WatchToysVM
    
    static var previews: some View {
        ContentView()
    }
}
