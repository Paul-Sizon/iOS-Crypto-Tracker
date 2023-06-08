//
//  cryptoApp.swift
//  crypto
//
//  Created by Pavel Sizonenko on 07.06.23.
//

import SwiftUI

@main
struct cryptoApp: App {
    let persistenceController = PersistenceController.shared
       var body: some Scene {
           WindowGroup {
               ContentView(viewModel: CryptoViewModel())
                   .environment(\.managedObjectContext, persistenceController.container.viewContext)
           }
       }
}
