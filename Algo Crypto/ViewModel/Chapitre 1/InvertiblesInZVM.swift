//
//  InvertiblesInZVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class InvertiblesInZVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var n: Int?
    private var model: InvertiblesInZ?
    var invertibles: [Int] {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.n = nil
        self.model = nil
    }
    
    init(model: InvertiblesInZ) {
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    // TODO: Si n est premier, les inverses sont tous les nombres de 0 à n-1
    func calculate() -> [Int] {
        if model != nil { return model!.invertibles }
        guard inputValidity() else { return [] }
        
        var inv: [Int] = []
        
        // Calcul des éléments inversables
        for i in 0..<n! {
            let euclidAlgo = EuclidAlgoVM(a: i, b: n!)
            if euclidAlgo.result == 1 {
                inv.append(i)
            }
        }
        
        return inv
    }
    
    
    func inputValidity() -> Bool {
        guard self.n != nil else { return false }
        guard self.n! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = InvertiblesInZ(n: n, invertibles: invertibles)
        } else {
            model!.setEvery(n: n, invertibles: invertibles)
        }
        context.insert(model!)
        return true
    }
    
    func deleteModel(context: ModelContext) {
        guard self.model != nil else { return }
        guard inputValidity() else { return }
        context.delete(self.model!)
    }
    
    
    func displayLabel() -> String {
        return "\("InvertibleIn".localized()) \("$\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}}$")"
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
    
    
    func getInversesList() -> [InverseTableObject] {
            var table: [InverseTableObject] = []
            
            for e in self.invertibles {
                let inv = InverseInZVM(a: e, n: n)
                table.append(InverseTableObject(invertables: "\(e)", inverses: "\(inv.inverse)"))
            }
            
            return table
        }
}
