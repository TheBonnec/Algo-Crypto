//
//  PrimeFactorsPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 25/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct PrimeFactorsPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [PrimeFactors]
    @StateObject var newPrimeFactors = PrimeFactorsVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().primeFactors.clé, newCalculation: newPrimeFactors, saves: saves, minimumSavesCellSize: 250) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "n", entréeNumérale: $newPrimeFactors.n)
            }
        } results: {
            CelluleResultat(
                description: newPrimeFactors.displayLabel(),
                résultat: newPrimeFactors.displayResult()
            )
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    Text(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    LaTeX(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: PrimeFactors) -> String {
        return "\(save.n ?? 0) se décompose en :"
    }
    
    func displaySavedResult(save: PrimeFactors) -> String {
        let values: [Int] = save.factors
        var display = "$"
        
        for value in values {
            display += "\(value) \\times "
        }
        
        if display != "$" {
            display.removeLast(8)
            display += "$"
        } else {
            display.removeLast()
        }
        
        return display
    }
}





#Preview {
    PrimeFactorsPage()
}
