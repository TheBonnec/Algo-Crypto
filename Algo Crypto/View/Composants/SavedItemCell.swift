//
//  SavedItemCell.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 19/11/2023.
//

import SwiftUI
import LaTeXSwiftUI


struct SavedItemCell: View {
    
    let label: String
    let solution: String
    
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(spacing: 16) {
                LaTeX(label)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                LaTeX(solution)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .fontWeight(.bold)
                
            }
            Spacer()
        }
        .padding()
        .background(Color.elémentTertiaire)
        .cornerRadius(8)
    }
}



enum SavedItemCellFormat {
    case carré, long
}





#Preview {
    SavedItemCell(label: "gcd(1, 4)", solution: "1")
}
