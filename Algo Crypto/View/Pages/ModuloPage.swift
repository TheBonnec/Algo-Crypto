//
//  ModuloPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI
import SwiftData


struct ModuloPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [Modulo]
    @StateObject var newModulo = ModuloVM()
    var savesVM: [ModuloVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<ModuloVM>(
            pageTitle: Pages().modulo.pageName,
            saves: savesVM,
            newCalculation: newModulo,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "x", placeholder: "0", input: $newModulo.x)
            NumberField(label: "a", placeholder: "1", input: $newModulo.a)
            NumberField(label: "n", placeholder: "0", input: $newModulo.n)
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [ModuloVM] {
        var s: [ModuloVM] = []
        for save in self.saves {
            let newSaveVM = ModuloVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    ModuloPage()
}
