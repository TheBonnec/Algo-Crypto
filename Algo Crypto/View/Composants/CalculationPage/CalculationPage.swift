//
//  CalculationPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import SwiftUI
import SwiftData


struct CalculationPage<T: CalculationProtocol, Content: View>: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [T]
    
    var pageTitle: String
    @Binding var page: Page
    @Binding var newCalculation: T
    @ViewBuilder var numberFields: Content
    var solutionSections: [SolutionSectionsData]
    
    
    var body: some View {
        PageNavigator(title: pageTitle, buttonTitle: "Page Principale") {
            self.page = .main
        } view: {
            
            
            VStack(spacing: 16) {
                // Entrées
                numberFields
                
                // Section de la solution
                ForEach(solutionSections) { ssd in
                    SolutionSection(label: ssd.label, solution: ssd.solution)
                }
                
                ACButton(label: "Sauvegarder") {
                    self.save()
                }
                
                
                
                // Liste des solutions sauvegardées
                List {
                    ForEach(saves) {save in
                        Text(save.displayInfo())
                    }
                    .onDelete(perform: delete)
                }
                .scrollContentBackground(.hidden)
                
                
                
                // Bouton pour supprimer les solutions sauvegardés
                ACButton(label: "Nettoyer", style: .destructive) {
                    self.deleteAll()
                }
            }
        }
    }
    
    
    func save() {
        newCalculation.calculate()
        modelContext.insert(newCalculation)
        newCalculation = T()
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
    CalculationPage<EuclidAlgo, Text>(pageTitle: "Euclid Algo", page: .constant(.euclid), newCalculation: .constant(EuclidAlgo()), numberFields: {
        Text("Hello")
    }, solutionSections: [SolutionSectionsData()])
}
