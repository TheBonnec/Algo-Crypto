//
//  ExtendedEuclidAlgoPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 14/11/2023.
//

import SwiftUI
import SwiftData
import CIUAisen


struct ExtendedEuclidAlgoPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [ExtendedEuclidAlgo]
    @StateObject var newExtendedEuclidAlgo = ExtendedEuclidAlgoVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().extendedEuclidAlgo.clé, newCalculation: newExtendedEuclidAlgo, saves: saves, minimumSavesCellSize: 200) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "a", entréeNumérale: $newExtendedEuclidAlgo.a)
                ChampDeTexte(label: "b", entréeNumérale: $newExtendedEuclidAlgo.b)
            }
        } results: {
            CelluleResultat(description: newExtendedEuclidAlgo.displayLabel()) {
                let result = newExtendedEuclidAlgo.result
                if newExtendedEuclidAlgo.inputValidity() {
                    Text("u\t\(result.u)\nv\t\(result.v)\nr\t\(result.r ?? 0)\nq\t\(result.q ?? 0)")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                } else {
                    Text(newExtendedEuclidAlgo.displayResult())
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    Text(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    Text(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: ExtendedEuclidAlgo) -> String {
        return "\("gcd".localized())(\(save.a ?? 0), \(save.b ?? 0))"
    }
    
    func displaySavedResult(save: ExtendedEuclidAlgo) -> String {
        return "\(save.r ?? 0)"
    }
}




#Preview {
    ExtendedEuclidAlgoPage()
}
