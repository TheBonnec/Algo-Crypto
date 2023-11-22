//
//  InvertiblesInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct InvertiblesInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [InvertiblesInZ]
    @StateObject var newInvertibles = InvertiblesInZVM()
    var savesVM: [InvertiblesInZVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<InvertiblesInZVM>(
            pageTitle: Pages().invertibleElementsInZ.pageName,
            saves: savesVM,
            newCalculation: newInvertibles,
            numberFields: AnyView(numberFields),
            customSolutionCells: [SolutionCell(content: AnyView(inversesTable))],
            minimumSavedItemCellSize: 500
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "n", placeholder: "1", input: $newInvertibles.n)
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
        .padding(.vertical, 8)
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [InvertiblesInZVM] {
        var s: [InvertiblesInZVM] = []
        for save in self.saves {
            let newSaveVM = InvertiblesInZVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    InvertiblesInZPage()
}
