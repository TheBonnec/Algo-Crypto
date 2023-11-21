//
//  CalculationPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import SwiftUI
import Combine
import SwiftData
import LaTeXSwiftUI


struct CalculationPage<U: CalculationVMProtocol>: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    
    var pageTitle: String
    var saves: [U]
    @ObservedObject var newCalculation: U
    var numberFields: AnyView
    var customSolutionCells: [SolutionCell]? = nil
    let minimumSavedItemCellSize: CGFloat
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Entrées
                numberFields
                
                // Solutions
                solutionSections
                
                // Boutons "Sauvegarder", "Réinitialiser", et "Nettoyer"
                actionButtons
                
                // Liste des calculs sauvegardés
                savedItemsGrid
            }
            .padding(.horizontal, 4)
            .padding(.vertical)
        }
        .navigationTitle(pageTitle)
        .scrollIndicators(.never)
        .onDisappear {
            self.save()
        }
    }
    
    
    
    var solutionSections: some View {
        Group {
            SolutionSection(label: newCalculation.displayLabel(), solution: newCalculation.displayResult())
            
            // Custom Solution Sections
            if customSolutionCells != nil {
                ForEach(customSolutionCells!) { cell in
                    cell
                }
            }
        }
    }
    
    
    
    var actionButtons: some View {
        HStack(spacing: 0) {
            ACButton(label: "Réinitialiser et Sauvegarder") {
                self.save()
            }
            
            ACButton(label: "Réinitialiser", style: .secondaryDestructive) {
                self.newCalculation.resetInputs()
            }
            
            // Bouton pour supprimer les solutions sauvegardés
            ACButton(label: "Nettoyer", style: .primaryDestructive) {
                self.deleteAll()
            }
        }
        .padding(.top, 16)
    }
    
    
    
    var savedItemsGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumSavedItemCellSize), spacing: 16)], spacing: 16) {
            ForEach(saves) { save in
                SavedItemCell(label: save.displayLabel(), solution: save.displayResult())
            }
        }
        .padding(.top, 64)
        .padding(.horizontal, 16)
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func save() {
        self.newCalculation.saveModel(context: modelContext)
        self.newCalculation.resetInputs()
    }
    
    func delete(save: U) {
        self.newCalculation.deleteModel(context: modelContext)
    }
    
    func deleteAll() {
        for save in saves {
            save.deleteModel(context: modelContext)
        }
    }
}





#Preview {
    CalculationPage<EuclidAlgoVM>(pageTitle: "Euclid Algo", saves: [EuclidAlgoVM()], newCalculation: EuclidAlgoVM(), numberFields: AnyView(Text("")), minimumSavedItemCellSize: 200)
}
