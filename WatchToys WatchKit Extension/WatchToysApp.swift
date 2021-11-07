//
//  WatchToysApp.swift
//  WatchToys WatchKit Extension
//
//  Created by Tim Miller on 11/7/21.
//

import SwiftUI

@main
struct WatchToysApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
