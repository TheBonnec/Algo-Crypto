//
//  InformationCell.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import LaTeXSwiftUI

struct InformationCell: View {
    
    var messageTitle: String?
    var content: String
    var type: InformationCellType = .normal
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if messageTitle != nil {
                    LaTeX(messageTitle!)
                        .foregroundStyle(type == .warning ? Color.pink : Color.primary)
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.bottom, 8)
                }
                
                LaTeX(content)
                    .foregroundStyle(type == .warning ? Color.pink : Color.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(type == .normal ? Color.fondTertiaire : Color.pink.opacity(0.16))
        .cornerRadius(8)
        .padding(.horizontal)
        .padding(.bottom, 32)
    }
    
    
    enum InformationCellType {
        case normal, warning
    }
}





#Preview {
    InformationCell(messageTitle: "", content: "")
}
