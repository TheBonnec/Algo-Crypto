//
//  EuclidAlgoView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import SwiftData


struct EuclidAlgoView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var euclidAlgos: [EuclidAlgo]
    @State var newAlgo = EuclidAlgo()
    @Binding var page: Page
    
    
    var body: some View {
        PageNavigator(title: "Euclidian Algorithm", buttonTitle: "Page Principale") {
            self.page = .main
        } view: {
            
            
            VStack(spacing: 16) {
                // Entrées
                HStack(spacing: 0) {
                    NumberField(label: "a", placeholder: "0", input: $newAlgo.a, onChangeAction: {
                        newAlgo.calculate()
                    })
                    NumberField(label: "b", placeholder: "0", input: $newAlgo.b, onChangeAction: {
                        newAlgo.calculate()
                    })
                }
                .background(Color(UIColor.systemBackground))
                
                // Section de la solution
                SolutionSection(label: "gcd(\(newAlgo.a ?? 0), \(newAlgo.b ?? 0))", solution: newAlgo.r)
                
                ACButton(label: "Sauvegarder") {
                    self.save()
                }
                
                
                
                // Liste des solutions sauvegardées
                List {
                    ForEach(euclidAlgos) {euclidAlgo in
                        Text("gcd(\(euclidAlgo.a ?? 0), \(euclidAlgo.b ?? 0)) = \(euclidAlgo.r)")
                    }
                    .onDelete(perform: delete)
                }
                .scrollContentBackground(.hidden)
                
                
                
                // Bouton pour supprimer les solutions sauvegardés
                ACButton(label: "Nettoyer", style: .destructive) {
                    self.deleteAll()
                }
            }
        }
    }
    
    
    func save() {
        newAlgo.calculate()
        modelContext.insert(newAlgo)
        newAlgo = EuclidAlgo()
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let euclidAlgo = euclidAlgos[index]
            modelContext.delete(euclidAlgo)
        }
    }
    
    func deleteAll() {
        for e in euclidAlgos {
            modelContext.delete(e)
        }
    }
}


#Preview {
    EuclidAlgoView(page: .constant(.euclid))
}
