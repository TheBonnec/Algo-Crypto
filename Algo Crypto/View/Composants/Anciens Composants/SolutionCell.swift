//
//  SolutionCell.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 14/11/2023.
//

import SwiftUI

struct SolutionCell: Identifiable, View {
    
    let id = UUID()
    var content: AnyView
    
    
    var body: some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
        .padding()
        .background(Color.elementSecondaire)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

#Preview {
    SolutionCell(content: AnyView(Text("")))
}
