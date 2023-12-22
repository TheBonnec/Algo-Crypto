//
//  GeneratorsPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct GeneratorsPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [Generators]
    @StateObject var newGenerators = GeneratorsVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().generators.clé, newCalculation: newGenerators, saves: saves, minimumSavesCellSize: 400) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "n", entréeNumérale: $newGenerators.n)
            }
        } results: {
            CelluleResultat(
                description: newGenerators.displayLabel(),
                résultat: newGenerators.displayResult()
            )
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    LaTeX(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    Text(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    
    func displaySavedLabel(save: Generators) -> String {
        if save.result.count < 2 {
            return "Le générateur du groupe $Inv(\\frac{\\mathbb{Z}}{\(save.n ?? 0)\\mathbb{Z}})$ est"
        }
        return "Les générateurs du groupe $Inv(\\frac{\\mathbb{Z}}{\(save.n ?? 0)\\mathbb{Z}})$ sont"
    }
    
    func displaySavedResult(save: Generators) -> String {
        var listString = ""
        for e in save.result {
            listString.append("\(e), ")
        }
        if !listString.isEmpty {
            listString.removeLast()
            listString.removeLast()
            return "\(listString)"
        } else {
            return "Aucune solution"
        }
    }
}





#Preview {
    GeneratorsPage()
}
