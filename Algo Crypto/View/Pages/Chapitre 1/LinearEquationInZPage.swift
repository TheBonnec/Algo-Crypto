//
//  LinearEquationInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct LinearEquationInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [LinearEquationInZ]
    @StateObject var newLinearEquation = LinearEquationInZVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().linearEquationInZ.clé, newCalculation: newLinearEquation, saves: saves, minimumSavesCellSize: 400) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newLinearEquation.a)
                ChampDeTexte(label: "b", entréeNumérale: $newLinearEquation.b)
                ChampDeTexte(label: "n", entréeNumérale: $newLinearEquation.n)
            }
        } results: {
            CelluleResultat(
                description: newLinearEquation.displayLabel(),
                résultat: newLinearEquation.displayResult()
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
    
    func displaySavedLabel(save: LinearEquationInZ) -> String {
        return "\("For".localized()) $x \\times \(save.a ?? 0) = \(save.b ?? 0)[\(save.n ?? 0)]$, x \("canTakeValue".localized())"
    }
    
    func displaySavedResult(save: LinearEquationInZ) -> String {
        var listString = ""
        for e in save.result {
            listString.append("\(e), ")
        }
        if !listString.isEmpty {
            listString.removeLast()
            listString.removeLast()
            return "\(listString)"
        } else {
            return "x n'a pas de solution"
        }
    }
}





#Preview {
    LinearEquationInZPage()
}
