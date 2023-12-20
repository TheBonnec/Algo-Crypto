//
//  LettersPreset.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 24/11/2023.
//

import Foundation


class LettersPreset {
    let allLetters: [Letter]
    
    
    init() {
        self.allLetters = [
            Letter("A"), Letter("B"), Letter("C"), Letter("D"), Letter("E"),
            Letter("F"), Letter("G"), Letter("H"), Letter("I"), Letter("J"),
            Letter("K"), Letter("L"), Letter("M"), Letter("N"), Letter("O"),
            Letter("P"), Letter("Q"), Letter("R"), Letter("S"), Letter("T"),
            Letter("U"), Letter("V"), Letter("W"), Letter("X"), Letter("Y"),
            Letter("Z"),
            
            Letter("0"), Letter("1"), Letter("2"), Letter("3"), Letter("4"),
            Letter("5"), Letter("6"), Letter("7"), Letter("8"), Letter("9"),
            
            Letter(" "), Letter("."), Letter(";"), Letter(","), Letter("("),
            Letter(")"), Letter("!"), Letter("?"), Letter("@"), Letter("#"),
            Letter("$"), Letter("%"), Letter("&")
        ]
    }
}
