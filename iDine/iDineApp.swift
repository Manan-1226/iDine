//
//  iDineApp.swift
//  iDine
//
//  Created by Daffolapmac-155 on 21/11/22.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
