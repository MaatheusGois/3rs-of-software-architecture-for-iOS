//
//  GlobalState.swift
//  BadCode
//
//  Created by Matheus Gois on 09/07/24.
//

import Foundation

class GlobalState {
    static let shared = GlobalState()
    var cart: [InventoryItem] = []
}
