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
            Congruence.self,
            EquivalenceClass.self,
            AdditionInZ.self,
            MultiplicationInZ.self,
            InvertiblesInZ.self,
            LinearEquationInZ.self,
            InverseInZ.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
        do {
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
                //.padding()
        }
        .modelContainer(sharedModelContainer)
        .defaultSize(CGSize(width: 1220, height: 860))
        .commands {
            CommandMenu("Mettre à Jour") {
                Button(action: {
                    if let url = URL(string: "https://github.com/TheBonnec/Algo-Crypto/releases") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text("Dernière version sur GitHub")
                })
            }
        }
    }
    
    func hideTitleBarOnCatalyst() {
        #if targetEnvironment(macCatalyst)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.titlebar?.titleVisibility = .hidden
        //(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.titlebar?.separatorStyle = .none
        
        //let toolbar = NSToolbar()
        
        //(UIApplication.shared.connectedScenes.first as? UIWindowScene)?.titlebar?.toolbar = .some(toolbar)
        #endif
    }
}
