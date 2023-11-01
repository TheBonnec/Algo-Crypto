//
//  SolutionSection.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI


struct SolutionSection: View {
    
    var label: String?
    var solution: Int?
    
     var body: some View {
         HStack {
             Spacer()
             VStack(spacing: 8) {
                 if label != nil {
                     Text(label!)
                         .foregroundStyle(Color.gray)
                 }
                 
                 if solution != nil {
                     Text("\(solution!)")
                         .font(.title)
                         .fontWeight(.bold)
                 }
             }
             Spacer()
         }
         .padding()
         .background(Color.cyan.opacity(0.15))
         .cornerRadius(8)
         .padding(.horizontal)
    }
}


#Preview {
    SolutionSection()
}
