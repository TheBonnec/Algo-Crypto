//
//  InversesInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct InversesInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newInversesList = InversesList()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<InversesList>(
            pageTitle: "Inverses in Z/nZ",
            newCalculation: $newInversesList,
            numberFields: AnyView(numberFields)
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "n", placeholder: "1", input: $newInversesList.n) {
                newInversesList.calculate()
            }
        }
    }
}





#Preview {
    InversesInZPage()
}
