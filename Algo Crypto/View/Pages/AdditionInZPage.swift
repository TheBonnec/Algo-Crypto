//
//  AdditionInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct AdditionInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newAddition = AdditionInZ()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<AdditionInZ>(
            pageTitle: "Addition in Z/nZ",
            newCalculation: $newAddition,
            numberFields: AnyView(numberFields),
            minimumSavedItemCellSize: 150
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newAddition.a) {
                newAddition.calculate()
            }
            NumberField(label: "b", placeholder: "0", input: $newAddition.b) {
                newAddition.calculate()
            }
            NumberField(label: "n", placeholder: "1", input: $newAddition.n) {
                newAddition.calculate()
            }
        }
    }
}





#Preview {
    AdditionInZPage()
}
