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
            InverseInZ.self,
            PrimeFactors.self,
            Phi.self,
            PolynomialEquation.self,
            OppositeKeyRSA.self,
            RSA.self,
            RSASignature.self,
            
            OrderInZ.self,
            CyclicGroup.self,
            Generators.self,
            OppositeKeyElGamal.self,
            ElGamalEncryption.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
        do {
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    //@State var finalAlphabet: [Letter] = []

    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //AlphabetSelectorView(finalAlphabet: $finalAlphabet)
                .onAppear(perform: {
                    hideTitleBarOnCatalyst()
                })
                //.padding()
        }
        .modelContainer(sharedModelContainer)
        .defaultSize(CGSize(width: 1220, height: 720))
        .commands {
            CommandMenu(LocalizedStringKey("Update")) {
                Button(action: {
                    if let url = URL(string: "https://github.com/TheBonnec/Algo-Crypto/releases") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    Text(LocalizedStringKey("LastGitHubVersion"))
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
