//
//  AdditionInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct AdditionInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [AdditionInZ]
    @StateObject var newAddition = AdditionInZVM()
    var savesVM: [AdditionInZVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<AdditionInZVM>(
            pageTitle: Pages().additionInZ.pageName,
            saves: savesVM,
            newCalculation: newAddition,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newAddition.a)
            NumberField(label: "b", placeholder: "0", input: $newAddition.b)
            NumberField(label: "n", placeholder: "1", input: $newAddition.n) 
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [AdditionInZVM] {
        var s: [AdditionInZVM] = []
        for save in self.saves {
            let newSaveVM = AdditionInZVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    AdditionInZPage()
}
