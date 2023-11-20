//
//  EquivalenceClassPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct EquivalenceClassPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newEquivalence = EquivalenceClass()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<EquivalenceClass>(
            pageTitle: "Equivalence Class",
            newCalculation: $newEquivalence,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 400
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newEquivalence.a) {
                newEquivalence.calculate()
            }
            NumberField(label: "n", placeholder: "0", input: $newEquivalence.n) {
                newEquivalence.calculate()
            }
        }
    }
}





#Preview {
    EquivalenceClassPage()
}
