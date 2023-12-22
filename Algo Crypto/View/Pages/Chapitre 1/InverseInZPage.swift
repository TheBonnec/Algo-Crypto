//
//  InverseInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct InverseInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [InverseInZ]
    @StateObject var newInverse = InverseInZVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().inverseInZ.clé, newCalculation: newInverse, saves: saves, minimumSavesCellSize: 250) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newInverse.a)
                ChampDeTexte(label: "n", entréeNumérale: $newInverse.n)
            }
        } results: {
            CelluleResultat(
                description: newInverse.displayLabel(),
                résultat: newInverse.displayResult()
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
    
    func displaySavedLabel(save: InverseInZ) -> String {
        return "\("InverseOf".localized()) \(save.a ?? 0) \("in".localized()) $\\frac{\\mathbb{Z}}{\(save.n ?? 0)\\mathbb{Z}}$"
    }
    
    func displaySavedResult(save: InverseInZ) -> String {
        if save.inverse == -1 {
            return "No inverse for \(save.a!)"
        } else if save.inverse == -2 {
            return "No inverse for $a \\geq n$"
        }
        return "\(save.inverse)"
    }
}





#Preview {
    InverseInZPage()
}
