//
//  ContentView.swift
//  GoodCode
//
//  Created by Matheus Gois on 08/07/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var centralState: Refactorability.CentralState

    var body: some View {
        TabView {
            Refactorability.InventoryList()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Inventory")
                }

            Refactorability.Cart()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
        }
    }
}

#Preview {
    ContentView()
}
