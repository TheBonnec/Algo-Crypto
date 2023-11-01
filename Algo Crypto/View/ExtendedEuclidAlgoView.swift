//
//  ExtendedEuclidAlgoView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import SwiftData


struct ExtendedEuclidAlgoView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var euclidAlgos: [ExtendedEuclidAlgo]
    @State var newAlgo = ExtendedEuclidAlgo()
    @Binding var page: Page
    
    
    var body: some View {
        PageNavigator(title: "Extended Euclidian Algorithm", buttonTitle: "Page Principale") {
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
                SolutionSection(label: "gcd(\(newAlgo.a ?? 0), \(newAlgo.b ?? 0))", solution: newAlgo.r ?? 0)
                SolutionSection(label: "u: \(newAlgo.u)\nv: \(newAlgo.v)\nr: \(newAlgo.r ?? 0)\nq: \(newAlgo.q ?? 0)")
                
                ACButton(label: "Sauvegarder") {
                    self.save()
                }
                
                
                
                // Liste des solutions sauvegardées
                List {
                    ForEach(euclidAlgos) {euclidAlgo in
                        Text("a: \(euclidAlgo.a ?? 0), b: \(euclidAlgo.b ?? 0), u: \(euclidAlgo.u), v: \(euclidAlgo.v), r: \(euclidAlgo.r ?? 0), q: \(euclidAlgo.q ?? 0)")
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
        newAlgo = ExtendedEuclidAlgo()
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
    ExtendedEuclidAlgoView(page: .constant(.extendedEuclid))
}
