//
//  AlphabetSelectorView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 23/11/2023.
//

import SwiftUI
import Combine


struct AlphabetSelectorView: View {
    
    @State var alphabet: [Letter] = LettersPreset().allLetters
    @Binding var finalAlphabet: [Letter]
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Alphabet")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.bottom, 48)
            
            HStack {
                ScrollView {
                    AlphabetSelectorSection(title: "Élément de l'alphabet", originAlphabet: $finalAlphabet, destinationAlphabet: $alphabet)
                    
                    AlphabetSelectorSection(title: "Éléments utilisables", originAlphabet: $alphabet, destinationAlphabet: $finalAlphabet)
                }
            }
            
            // Pre-sélections
            VStack {
                
            }
        }
        .onChange(of: alphabet) { oldValue, newValue in
            let aL = LettersPreset().allLetters
            /*alphabet.sort{ letterA, letterB in
                let letterAIndex = aL.firstIndex(where: $0.id == letterA.id)
                let letterBIndex = aL.firstIndex(where: $0.id == letterB.id)
                return letterAIndex < letterBIndex
            }*/
        }
    }
    
    
    
    func deleteLetter(indexSet: IndexSet) {
        alphabet.remove(atOffsets: indexSet)
    }
    
    
    func inputValidity(i: Int) {
        if alphabet[i].value.count > 1 {
            alphabet[i].value = String(alphabet[i].value.prefix(1))
        }
    }
}




#Preview {
    AlphabetSelectorView(finalAlphabet: .constant([]))
}
