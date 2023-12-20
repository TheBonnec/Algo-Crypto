//
//  LinearEquationInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct LinearEquationInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [LinearEquationInZ]
    @StateObject var newLinearEquation = LinearEquationInZVM()
    var savesVM: [LinearEquationInZVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<LinearEquationInZVM>(
            pageTitle: Pages().linearEquationInZ.pageName,
            saves: savesVM,
            newCalculation: newLinearEquation,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 400
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newLinearEquation.a)
            NumberField(label: "b", placeholder: "0", input: $newLinearEquation.b)
            NumberField(label: "n", placeholder: "0", input: $newLinearEquation.n)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [LinearEquationInZVM] {
        var s: [LinearEquationInZVM] = []
        for save in self.saves {
            let newSaveVM = LinearEquationInZVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    LinearEquationInZPage()
}
