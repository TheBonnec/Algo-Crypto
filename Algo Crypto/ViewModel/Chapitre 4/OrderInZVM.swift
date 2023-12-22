//
//  OrderInZVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import SwiftData
import SwiftUI
import Combine


class OrderInZVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var n: Int?
    @Published var k: Int?
    private var model: OrderInZ?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.n = nil
        self.k = nil
        self.model = nil
    }
    
    init(model: OrderInZ) {
        self.n = model.n
        self.k = model.k
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        guard inputValidity() else { return -1 }
        
        let phi = PhiVM(n: self.n!).result
        let gcd = EuclidAlgoVM(a: self.k!, b: self.n!).result
        
        // Si gcd != 1 -> k non inversible -> pas d'ordre
        guard gcd == 1 else { return -2 }
        
        // Force brute
        for i in 0...phi {
            let puissance = ModuloVM(x: self.k!, a: i, n: self.n!).result   // Calcul k puissance i modulo n
            if puissance == 1 {
                return i
            }
        }
        
        return -3
    }
    
    
    func inputValidity() -> Bool {
        guard self.n != nil && self.n! > 1 else { return false }
        guard self.k != nil && self.k! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.n = nil
        self.k = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = OrderInZ(n: n, k: k, result: result)
        } else {
            model!.setEvery(n: n, k: k, result: result)
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
        return "L'ordre de \(k ?? 0) dans $Inv(\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}})$ est"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        
        if result == -2 {
            return "\(k ?? 0) n'est pas inversible, donc n'a pas d'ordre"
        } else if result == -3 {
            return "Une erreur est survenue"
        }
        
        return "\(result)"
    }
}
