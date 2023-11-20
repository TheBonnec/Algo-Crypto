//
//  InverseInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct InverseInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newInverse = InverseInZ()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<InverseInZ>(
            pageTitle: "Inverse in Z/nZ",
            newCalculation: $newInverse,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 250
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newInverse.a) {
                newInverse.calculate()
            }
            NumberField(label: "n", placeholder: "1", input: $newInverse.n) {
                newInverse.calculate()
            }
        }
    }
}





#Preview {
    InverseInZPage()
}
