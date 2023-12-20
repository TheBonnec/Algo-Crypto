//
//  IsPrime.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftUI


extension Int {
    func isPrime() -> Bool {
        // Les nombres inférieurs à 2 ne sont pas premiers
        guard self > 1 else {
            return false
        }
        
        if self == 2 || self == 3 {
            return true
        }

        // Vérifie les diviseurs potentiels jusqu'à la racine carrée du nombre
        for i in 2...Int(Double(self).squareRoot()) {
            if self % i == 0 {
                // Le nombre est divisible, donc il n'est pas premier
                return false
            }
        }

        // Si aucun diviseur n'a été trouvé, le nombre est premier
        return true
    }
}
