//
//  AlphabetSelectorSection.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 24/11/2023.
//

import SwiftUI

struct AlphabetSelectorSection: View {
    
    var title: String
    @Binding var originAlphabet: [Letter]
    @Binding var destinationAlphabet: [Letter]
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .padding(.vertical, 8)
                
                Spacer()
            }
            
            if originAlphabet != [] {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], content: {
                    ForEach(originAlphabet) { letter in
                        AlphabetSelectorCell(letter: letter).onTapGesture {
                            let i = originAlphabet.firstIndex(of: letter)!
                            originAlphabet[i].selected.toggle()
                            destinationAlphabet.append(originAlphabet[i])
                            originAlphabet.remove(at: i)
                        }
                    }
                })
            } else {
                Text("Non ! Rien de rien !")
                    .frame(height: 50)
            }
        }
    }
}

#Preview {
    AlphabetSelectorSection(
        title: "Alphabet d'origine",
        originAlphabet: .constant(LettersPreset().allLetters),
        destinationAlphabet: .constant([]))
}
