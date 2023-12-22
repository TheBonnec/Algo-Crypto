//
//  OppositeKeyPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI


struct OppositeKeyRSAPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [OppositeKeyRSA]
    @StateObject var newOppositeKey = OppositeKeyRSAVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().oppositeKeyRSA.clé, newCalculation: newOppositeKey, saves: saves, minimumSavesCellSize: 250) {
            inputs
        } results: {
            warnings
            
            CelluleResultat(
                description: newOppositeKey.displayLabel(),
                résultat: newOppositeKey.displayResult()
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
    
    
    var inputs: some View {
        VStack(spacing: 16) {
            HStack {
                LaTeX("Pour calculer $d_A$ : entrer $e_A$ dans 'Clef d'origine' puis $\\phi(n)$\nPour calculer $e_A$ : entrer $d_A$ dans 'Clef d'origine' puis $\\phi(n)$")
                    .foregroundStyle(Color.texteSecondaire)
                Spacer()
            }
            .padding(.bottom, 24)
            
            HStack(spacing: 16) {
                ChampDeTexte(label: "Clef d'origine", entréeNumérale: $newOppositeKey.originalKey)
                ChampDeTexte(label: "φ(n)", entréeNumérale: $newOppositeKey.phi)
            }
        }
    }
    
    
    var warnings: some View {
        Group {
            let isSolutionExisting = newOppositeKey.isSolutionExisting()
            if isSolutionExisting == -1 {
                CelluleRouge {
                    Text("AVERTISSEMENT")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.teinteAvertissement)
                    
                    LaTeX("Les nombres entrés sont trop grands. $e \\times d ≡ 1[\\phi(n)]$ n'a pas pu être calculé. Il est possible que la clef calculé ne soit pas valide.")
                        .foregroundStyle(Color.teinteAvertissement)
                }
            } else if isSolutionExisting != 1 {
                CelluleRouge {
                    Text("AVERTISSEMENT")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.teinteAvertissement)
                    
                    LaTeX("$e \\times d$ n'est pas égal à $1[\\phi(n)]$.\nCela indique que $e$ ou $d$ n'est pas valide.")
                        .foregroundStyle(Color.teinteAvertissement)
                }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: OppositeKeyRSA) -> String {
        return "La clef opposée à \(save.originalKey ?? 0) est"
    }
    
    func displaySavedResult(save: OppositeKeyRSA) -> String {
        return "\(save.finalKey)"
    }
}






#Preview {
    OppositeKeyRSAPage()
}
