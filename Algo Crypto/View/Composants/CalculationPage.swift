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


struct CalculationPage<U: CalculationProtocol>: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [U]
    
    var pageTitle: String
    @Binding var newCalculation: U
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
        guard newCalculation.inputValidity() else { return }
        newCalculation.calculate()
        modelContext.insert(newCalculation)
        newCalculation = U()
    }
    
    func delete(save: U) {
        modelContext.delete(save)
    }
    
    func deleteAll() {
        for save in saves {
            modelContext.delete(save)
        }
    }
}





#Preview {
    CalculationPage<EuclidAlgo>(pageTitle: "Euclid Algo", newCalculation: .constant(EuclidAlgo()), numberFields: AnyView(Text("")), minimumSavedItemCellSize: 200)
}
