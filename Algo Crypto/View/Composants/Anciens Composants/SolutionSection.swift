//
//  SolutionSection.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import LaTeXSwiftUI


struct SolutionSection: View {
    
    var label: String?
    var solution: String?
    
     var body: some View {
         SolutionCell(content: AnyView(
            VStack(spacing: 8) {
                if label != nil {
                    LaTeX(label!)
                        .foregroundStyle(Color.gray)
                }
                
                if solution != nil {
                    if solution == "Input Error" {
                        Text(LocalizedStringKey("InputError"))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    } else {
                        LaTeX(solution!)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
         ))
    }
}


#Preview {
    SolutionSection()
}
