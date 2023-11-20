//
//  ModuloPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct ModuloPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newModulo = Modulo()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<Modulo>(
            pageTitle: "Modulo",
            newCalculation: $newModulo,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "x", placeholder: "0", input: $newModulo.x, onChangeAction: {
                newModulo.calculate()
            })
            NumberField(label: "a", placeholder: "1", input: $newModulo.a, onChangeAction: {
                newModulo.calculate()
            })
            NumberField(label: "n", placeholder: "0", input: $newModulo.n, onChangeAction: {
                newModulo.calculate()
            })
        }
    }
}





#Preview {
    ModuloPage()
}
