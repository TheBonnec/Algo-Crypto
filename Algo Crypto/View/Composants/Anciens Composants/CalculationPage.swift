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
    
    var pageTitle: LocalizedStringKey
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
                if saves.count != 0 {
                    savedItemsGrid
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical)
        }
        .navigationTitle(pageTitle)
        .scrollIndicators(.never)
        .onDisappear {
            //self.save()
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
            ACButton(label: "SaveAndReset") {
                self.save()
            }
            
            ACButton(label: "Reset", style: .secondaryDestructive) {
                self.newCalculation.resetInputs()
            }
            
            // Bouton pour supprimer les solutions sauvegardés
            ACButton(label: "Clean", style: .primaryDestructive) {
                self.deleteAll()
            }
        }
        .padding(.top, 16)
    }
    
    
    
    var savedItemsGrid: some View {
        LazyVStack(alignment: .leading) {
            Text(LocalizedStringKey("SavedCalculations"))
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 16)
            
            if saves.count != 0 {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumSavedItemCellSize), spacing: 16)], spacing: 16) {
                    ForEach(saves, id: \.id) { save in
                        SavedItemCell(label: save.displayLabel(), solution: save.displayResult())
                        /*
                        if type(of: save) == PrimeFactorsVM.self {
                            let s = save as! PrimeFactorsVM
                            SavedItemCell(label: s.constantDisplayLabel, solution: s.constantDisplayResult)
                        } else {
                            SavedItemCell(label: save.displayLabel(), solution: save.displayResult())
                        }
                        */
                    }
                }
            } else {
                HStack {
                    Spacer()
                    Text(LocalizedStringKey("TheVoid"))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .frame(height: 200)
            }
        }
        .padding(.top, 64)
        .padding(.horizontal, 16)
    }
    
    
    
    
    
    /* ----- Méthodes ----- */
    
    func save() {
        guard self.newCalculation.saveModel(context: modelContext) else { return }
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
    CalculationPage<EuclidAlgoVM>(pageTitle: "Euclid Algo", saves: [], newCalculation: EuclidAlgoVM(), numberFields: AnyView(Text("")), minimumSavedItemCellSize: 200)
}
