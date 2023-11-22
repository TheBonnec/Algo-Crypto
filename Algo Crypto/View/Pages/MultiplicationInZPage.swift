//
//  MultiplicationInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct MultiplicationInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [MultiplicationInZ]
    @StateObject var newMultiplication = MultiplicationInZVM()
    var savesVM: [MultiplicationInZVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<MultiplicationInZVM>(
            pageTitle: Pages().multiplicationInZ.pageName,
            saves: savesVM,
            newCalculation: newMultiplication,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newMultiplication.a)
            NumberField(label: "b", placeholder: "0", input: $newMultiplication.b)
            NumberField(label: "n", placeholder: "1", input: $newMultiplication.n)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [MultiplicationInZVM] {
        var s: [MultiplicationInZVM] = []
        for save in self.saves {
            let newSaveVM = MultiplicationInZVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    MultiplicationInZPage()
}
