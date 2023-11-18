//
//  CongruenceView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct CongruenceView: View {
    
    /* ----- Propriétés ----- */
    
    @State var newCongruence = Congruence()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<Congruence>(
            pageTitle: "Congruence",
            newCalculation: $newCongruence,
            numberFields: AnyView(numberFields)
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "a", placeholder: "0", input: $newCongruence.a) {
                newCongruence.calculate()
            }
            NumberField(label: "p", placeholder: "1", input: $newCongruence.p) {
                newCongruence.calculate()
            }
            NumberField(label: "b", placeholder: "0", input: $newCongruence.b) {
                newCongruence.calculate()
            }
            NumberField(label: "q", placeholder: "1", input: $newCongruence.q) {
                newCongruence.calculate()
            }
            NumberField(label: "n", placeholder: "0", input: $newCongruence.n) {
                newCongruence.calculate()
            }
        }
    }
}





#Preview {
    CongruenceView()
}
