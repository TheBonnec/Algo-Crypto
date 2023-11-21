//
//  CalculationVMProtocol.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 20/11/2023.
//

import Foundation
import SwiftData


protocol CalculationVMProtocol: ObservableObject, Identifiable {
    var id: UUID { get }
    
    init()
    
    //func calculate()
    func inputValidity() -> Bool
    func resetInputs()
    
    func saveModel(context: ModelContext)
    func deleteModel(context: ModelContext)
    
    func displayLabel() -> String
    func displayResult() -> String
}
