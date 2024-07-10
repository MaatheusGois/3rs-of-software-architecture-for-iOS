//
//  GoodCodeApp.swift
//  GoodCode
//
//  Created by Matheus Gois on 08/07/24.
//

import SwiftUI

@main
struct GoodCodeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Refactorability.CentralState.mock)
        }
    }
}
