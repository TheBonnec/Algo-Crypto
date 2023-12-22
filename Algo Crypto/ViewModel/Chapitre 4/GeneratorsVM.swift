//
//  GeneratorsVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftData
import SwiftUI
import Combine


class GeneratorsVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var n: Int?
    private var model: Generators?
    var result: [Int] {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.n = nil
        self.model = nil
    }
    
    init(model: Generators) {
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> [Int] {
        guard inputValidity() else { return [] }
        
        if !CyclicGroupVM(n: n).result {
            print(n ?? 0)
            return []
        }
        
        var generators: [Int] = []
        
        let phi = PhiVM(n: n!).result
        for a in 1..<n! {
            if EuclidAlgoVM(a: a, b: n!).result == 1 {
                var isGenerator = true
                let m = phi
                
                // Vérifier tous les diviseurs de phi(n)
                for divisor in 2...phi where phi % divisor == 0 {
                    if ModuloVM(x: a, a: m/divisor, n: n!).result == 1 {
                        isGenerator = false
                        break
                    }
                }
                if isGenerator {
                    generators.append(a)
                }
            }
        }
        return generators
    }
    
    
    func inputValidity() -> Bool {
        guard self.n != nil && self.n! > 1 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = Generators(n: n, result: result)
        } else {
            model!.setEvery(n: n, result: result)
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
        if result.count < 2 {
            return "Le générateur du groupe $Inv(\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}})$ est"
        }
        return "Les générateurs du groupe $Inv(\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}})$ sont"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        
        var listString = ""
        for e in self.result {
            listString.append("\(e), ")
        }
        if !listString.isEmpty {
            listString.removeLast()
            listString.removeLast()
            return "\(listString)"
        } else {
            return "Aucune solution"
        }
    }
}
