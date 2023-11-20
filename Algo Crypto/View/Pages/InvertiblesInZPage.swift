//
//  InvertiblesInZPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 15/11/2023.
//

import SwiftUI

struct InvertiblesInZPage: View {
    
    /* ----- Propriétés ----- */
    
    @State var newInvertibles = InvertiblesInZ()
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        CalculationPage<InvertiblesInZ>(
            pageTitle: "Invertible Elements in Z/nZ",
            newCalculation: $newInvertibles,
            numberFields: AnyView(numberFields),
            customSolutionCells: [SolutionCell(content: AnyView(inversesTable))],
            minimumSavedItemCellSize: 500
        )
    }
    
    
    var numberFields: some View {
        HStack(spacing: 0) {
            NumberField(label: "n", placeholder: "1", input: $newInvertibles.n) {
                newInvertibles.calculate()
            }
        }
    }
    
    
    var inversesTable: some View {
        HStack(spacing: 0) {
            // Légende
            VStack(spacing: 0) {
                Text("Éléments Inversables")
                    .padding()
                
                Divider()
                
                Text("Inverses")
                    .padding()
            }
            
            Divider()
            
            // Contenu
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(newInvertibles.getInversesList()) { item in
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text(item.invertables)
                                    .padding()
                                
                                Divider()
                                
                                Text(item.inverses)
                                    .padding()
                            }
                            Divider()
                        }
                    }
                }
            }
        }
        .border(width: 0.33, color: .gray, cornerRadius: 8)
        .padding(.vertical, 8)
    }
}





#Preview {
    InvertiblesInZPage()
}
