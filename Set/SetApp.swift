//
//  SetApp.swift
//  Set
//
//  Created by Julio leon on 3/6/23.
//

import SwiftUI

@main
struct SetApp: App {
    var game = SetViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
