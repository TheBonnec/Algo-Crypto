//
//  CongruenceView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import SwiftUI

struct CongruenceView: View {
    
    @State var newCongruence = Congruence()
    @Binding var page: Page
    
    
    var body: some View {
        CalculationPage<Congruence, HStack>(
            pageTitle: "Congruence",
            page: $page,
            newCalculation: $newCongruence,
            numberFields: {
                HStack(spacing: 0) {
                    NumberField(placeholder: "x", input: $newCongruence.x) {
                        newCongruence.calculate()
                    }
                    NumberField(placeholder: "a", input: $newCongruence.a) {
                        newCongruence.calculate()
                    }
                    NumberField(placeholder: "y", input: $newCongruence.y) {
                        newCongruence.calculate()
                    }
                    NumberField(placeholder: "b", input: $newCongruence.b) {
                        newCongruence.calculate()
                    }
                    NumberField(placeholder: "n", input: $newCongruence.n) {
                        newCongruence.calculate()
                    }
                }
        },
            solutionSections: [SolutionSectionsData(label: "\(newCongruence.x ?? 0)^\(newCongruence.a ?? 0) ≡ \(newCongruence.y ?? 0)^\(newCongruence.b ?? 0)[\(newCongruence.n ?? 0)]", solution: newCongruence.result)])
    }
}




#Preview {
    CongruenceView(page: .constant(.congruence))
}
