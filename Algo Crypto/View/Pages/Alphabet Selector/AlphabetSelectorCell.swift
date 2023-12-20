//
//  AlphabetSelectorCell.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 24/11/2023.
//

import SwiftUI

struct AlphabetSelectorCell: View {
    
    var letter: Letter
    
    var body: some View {
        Text(letter.value)
            .font(.title2)
            .fontWeight(.medium)
            .frame(width: 50, height: 50)
            .background(letter.selected ? Color.elementSecondaire : Color.elementTertiaire)
            .cornerRadius(6)
    }
}

#Preview {
    AlphabetSelectorCell(letter: Letter("A"))
}
