//
//  InversesList.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 09/11/2023.
//

import Foundation
import SwiftData


@Model
final class InversesList: CalculationProtocol {
    
    var n: Int?
    private(set) var list: [Int]
    
    
    init() {
        self.n = nil
        self.list = []
    }
    
    init(n: Int?, list: [Int]) {
        self.n = n
        self.list = list
    }
    
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        var inversables: [Int] = []
        
        for i in 0..<n! {
            let euclidAlgo = EuclidAlgo(a: i, b: n!)
            euclidAlgo.calculate()
            if euclidAlgo.r == 1 {
                inversables.append(i)
            }
        }
        
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
    
    func displayInfo() -> String {
        var listString = ""
        for e in self.list {
            listString.append("\(e), ")
        }
        if !listString.isEmpty {
            listString.removeLast()
            listString.removeLast()
        }
        
        return "Les éléments inversable dans $\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}}$ sont : \(listString)\n"
    }
    
    
}
