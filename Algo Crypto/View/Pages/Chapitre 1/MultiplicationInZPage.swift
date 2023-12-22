//
//  MultiplicationInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct MultiplicationInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [MultiplicationInZ]
    @StateObject var newMultiplication = MultiplicationInZVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().multiplicationInZ.clé, newCalculation: newMultiplication, saves: saves, minimumSavesCellSize: 150) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newMultiplication.a)
                ChampDeTexte(label: "b", entréeNumérale: $newMultiplication.b)
                ChampDeTexte(label: "n", entréeNumérale: $newMultiplication.n)
            }
        } results: {
            CelluleResultat(
                description: newMultiplication.displayLabel(),
                résultat: newMultiplication.displayResult()
            )
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    LaTeX(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    LaTeX(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: MultiplicationInZ) -> String {
        return "$\\bar{\(save.a ?? 0)} ⊗ \\bar{\(save.b ?? 0)}$"
    }
    
    func displaySavedResult(save: MultiplicationInZ) -> String {
        return "$\\bar{\(save.result)}$"
    }
}





#Preview {
    MultiplicationInZPage()
}
