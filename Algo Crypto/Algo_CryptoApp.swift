//
//  Algo_CryptoApp.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import SwiftData

@main
struct Algo_CryptoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            EuclidAlgo.self,
            ExtendedEuclidAlgo.self,
            Modulo.self,
            Congruence.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
        do {
            print(schema, modelConfiguration)
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    hideTitleBarOnCatalyst()
                })
                .padding()
        }
        .modelContainer(sharedModelContainer)
        .defaultSize(CGSize(width: 720, height: 860))
    }
    
    func hideTitleBarOnCatalyst() {
        #if targetEnvironment(macCatalyst)
        //(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
        //(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.titlebar?.separatorStyle = .none
        
        let toolbar = NSToolbar()
        
        
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.titlebar?.toolbar = .some(toolbar)
        #endif
    }
}
