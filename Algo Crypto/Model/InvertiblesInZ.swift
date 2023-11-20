//
//  InvertiblesInZ.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 09/11/2023.
//

import Foundation
import SwiftData


@Model
final class InvertiblesInZ: CalculationProtocol {
    
    var n: Int?
    private(set) var invertibles: [Int]
    
    
    init() {
        self.n = nil
        self.invertibles = []
    }
    
    init(n: Int?, invertibleElements: [Int]) {
        self.n = n
        self.invertibles = invertibleElements
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
        self.invertibles = inversables
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
            for e in self.invertibles {
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
        self.invertibles = []
    }
    
    
    func getInversesList() -> [InverseTableObject] {
        var table: [InverseTableObject] = []
        
        for e in self.invertibles {
            let inv = InverseInZ(a: e, n: n)
            inv.calculate()
            table.append(InverseTableObject(invertables: "\(e)", inverses: "\(inv.inverse)"))
        }
        
        return table
    }
}





struct InverseTableObject: Identifiable {
    let id = UUID()
    let invertables: String
    let inverses: String
}
