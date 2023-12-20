//
//  PhiPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import SwiftData


struct PhiPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [Phi]
    @StateObject var newPhi = PhiVM()
    var savesVM: [PhiVM] {
        updateSavesVM()
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<PhiVM>(
            pageTitle: Pages().phi.pageName,
            saves: savesVM,
            newCalculation: newPhi,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            switch newPhi.mode {
            case .n:
                NumberField(label: "n", placeholder: "1", input: $newPhi.n)
                ACButton(label: "Calculer avec p et q", style: .tertiary) { newPhi.mode = .pq }
                ACButton(label: "Calculer avec n et k", style: .tertiary) { newPhi.mode = .nk }
            case .pq:
                NumberField(label: "p", placeholder: "1", input: $newPhi.p)
                NumberField(label: "q", placeholder: "1", input: $newPhi.q)
                ACButton(label: "Calculer avec n", style: .tertiary) { newPhi.mode = .n }
                ACButton(label: "Calculer avec n et k", style: .tertiary) { newPhi.mode = .nk }
            case .nk:
                NumberField(label: "n", placeholder: "1", input: $newPhi.n)
                NumberField(label: "k", placeholder: "1", input: $newPhi.k)
                ACButton(label: "Calculer avec n", style: .tertiary) { newPhi.mode = .n }
                ACButton(label: "Calculer avec p et q", style: .tertiary) { newPhi.mode = .pq }
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func updateSavesVM() -> [PhiVM] {
        var s: [PhiVM] = []
        for save in self.saves {
            let newSaveVM = PhiVM(model: save)
            s.append(newSaveVM)
        }
        return s
    }
}





#Preview {
    PhiPage()
}
