//
//  InvertiblesInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct InvertiblesInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [InvertiblesInZ]
    @StateObject var newInvertibles = InvertiblesInZVM()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().invertibleElementsInZ.clé, newCalculation: newInvertibles, saves: saves, minimumSavesCellSize: 400) {
            HStack(spacing: 16) {
                ChampDeTexte(label: "n", entréeNumérale: $newInvertibles.n)
            }
        } results: {
            CelluleResultat(
                description: newInvertibles.displayLabel()) {
                    inversesTable
                }
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
    
    
    var inversesTable: some View {
        HStack(spacing: 0) {
            // Légende
            VStack(spacing: 0) {
                Text(LocalizedStringKey("InvertibleElements"))
                    .padding()
                
                Divider()
                
                Text(LocalizedStringKey("Inverses"))
                    .padding()
            }
            
            Divider()
            
            // Contenu
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(newInvertibles.getInversesList()) { item in
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text(item.invertables)
                                    .padding()
                                
                                Divider()
                                
                                Text(item.inverses)
                                    .padding()
                            }
                            Divider()
                        }
                    }
                }
            }
        }
        .border(width: 0.33, color: .gray, cornerRadius: 8)
        .padding(.top, 8)
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: InvertiblesInZ) -> String {
        return "\("InvertibleIn".localized()) \("$\\frac{\\mathbb{Z}}{\(save.n ?? 0)\\mathbb{Z}}$")"
    }
    
    func displaySavedResult(save: InvertiblesInZ) -> String {
        if save.n! >= 0 {
            var listString = ""
            for e in save.invertibles {
                listString.append("\(e), ")
            }
            if !listString.isEmpty {
                listString.removeLast()
                listString.removeLast()
            }
            
            return "\(listString)"
        }
        return "Pas de solution pour n < 0"
    }
}





#Preview {
    InvertiblesInZPage()
}
