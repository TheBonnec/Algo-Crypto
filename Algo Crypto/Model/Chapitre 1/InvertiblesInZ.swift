//
//  InvertiblesInZ.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 09/11/2023.
//

import Foundation
import SwiftData


@Model
final class InvertiblesInZ {
    
    var n: Int?
    var invertibles: [Int]
    
    init(n: Int? = nil, invertibles: [Int] = []) {
        self.n = n
        self.invertibles = invertibles
    }
    
    func setEvery(n: Int?, invertibles: [Int]) {
        self.n = n
        self.invertibles = invertibles
    }
}





struct InverseTableObject: Identifiable {
    let id = UUID()
    let invertables: String
    let inverses: String
}
