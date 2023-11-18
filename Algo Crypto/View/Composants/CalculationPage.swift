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
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [U]
    
    var pageTitle: String
    @Binding var newCalculation: U
    var numberFields: AnyView
    var solutionSections: [SolutionSectionsData]?
    var customSolutionSections: AnyView? = nil
    
    
    var body: some View {
        VStack(spacing: 16) {
            // Entrées
            numberFields
            
            
            SolutionSection(label: newCalculation.displayLabel(), solution: newCalculation.displayResult())
            
            // Sections additionnelles de la solution
            if solutionSections != nil {
                ForEach(solutionSections!) { ssd in
                    SolutionSection(label: ssd.label, solution: ssd.solution)
                }
            }
            
            // Solution Sections Custom
            if customSolutionSections != nil {
                customSolutionSections!
            }
            
            
            HStack(spacing: 0) {
                ACButton(label: "Réinitialiser et Sauvegarder") {
                    self.save()
                }
                
                // Bouton pour supprimer les solutions sauvegardés
                ACButton(label: "Nettoyer", style: .destructive) {
                    self.deleteAll()
                }
            }
            .padding(.top, 16)
            
            
            
            // Liste des solutions sauvegardées
            List {
                ForEach(saves) {save in
                    LaTeX("\(save.displayLabel())   ->   \(save.displayResult())")
                }
                .onDelete(perform: delete)
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle(pageTitle)
        .onDisappear {
            self.save()
        }
    }
    
    
    func save() {
        guard newCalculation.inputValidity() else { return }
        newCalculation.calculate()
        modelContext.insert(newCalculation)
        newCalculation = U()
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let calculation = saves[index]
            modelContext.delete(calculation)
        }
    }
    
    func deleteAll() {
        for save in saves {
            modelContext.delete(save)
        }
    }
}





#Preview {
    CalculationPage<EuclidAlgo>(pageTitle: "Euclid Algo", newCalculation: .constant(EuclidAlgo()), numberFields: AnyView(Text("")), solutionSections: [SolutionSectionsData()])
}
