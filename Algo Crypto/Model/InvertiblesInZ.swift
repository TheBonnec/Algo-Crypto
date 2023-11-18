//
//  InversesList.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 09/11/2023.
//

import Foundation
import SwiftData


@Model
final class InvertiblesInZ: CalculationProtocol {
    
    var n: Int?
    var list: [Int]
    //private(set) var inverses: [Int]
    
    
    init() {
        self.n = nil
        self.list = []
        //self.inverses = []
    }
    
    init(n: Int?, inversableElements: [Int]) {
        self.n = n
        self.list = inversableElements
        //self.inverses = inverses
    }
    
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        var inversables: [Int] = []
        
        // Calcul des éléments inversables
        for i in 0..<n! {
            let euclidAlgo = EuclidAlgo(a: i, b: n!, r: 0)
            euclidAlgo.calculate()
            if euclidAlgo.r == 1 {
                inversables.append(i)
            }
        }
        /*
        // Calcul des inverses
        for iE in self.list {
            let inv = InverseInZ(a: iE, n: n)
            inv.calculate()
            self.inverses.append(inv.inverse)
        }
         */
        
        self.list = inversables
    }
    
    
    
    func inputValidity() -> Bool {
        guard n != nil else { return false }
        guard n! > 0 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "Éléments inversable dans $\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}}$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        
        if n! >= 0 {
            var listString = ""
            for e in self.list {
                listString.append("\(e), ")
            }
            if !listString.isEmpty {
                listString.removeLast()
                listString.removeLast()
            }
            
            return "\(listString)"
        }
        return "Pas de solution pour n < 0"
    }
    
    
    func resetInputs() {
        self.n = nil
        self.list = []
    }
    
    
    func getInversesDict() -> [InverseTableObject] {
        var table: [InverseTableObject] = []
        
        for e in self.list {
            let inv = InverseInZ(a: e, n: n)
            inv.calculate()
            table.append(InverseTableObject(inversable: "\(e)", inverse: "\(inv.inverse)"))
        }
        
        return table
    }
}





struct InverseTableObject: Identifiable {
    let id = UUID()
    let inversable: String
    let inverse: String
}
