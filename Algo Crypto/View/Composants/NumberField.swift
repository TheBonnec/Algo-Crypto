//
//  NumberField.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI


struct NumberField: View {
    
    var label: String?
    var placeholder: String
    @Binding var input: Int?
    var onChangeAction: () -> Void
    
    @FocusState var focused: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if label != nil {
                Text(label!)
                    .foregroundStyle(focused ? Color.cyan : Color.black)
            }
            
            TextField("\(placeholder)", value: $input, format: .number)
                .focused($focused)
                .font(.title2)
                .onChange(of: input) { oldValue, newValue in
                    onChangeAction()
                }
        }
        .padding(.horizontal, 0)
        .padding([.vertical], 6)
        .border(width: 1, edges: [.bottom], color: focused ? .cyan : Color(UIColor.lightGray))
        .padding(.horizontal, 16)
    }
}
