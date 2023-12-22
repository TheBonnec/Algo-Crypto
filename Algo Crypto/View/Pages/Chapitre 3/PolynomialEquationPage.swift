//
//  PolynomialEquationPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import SwiftUI
import CIUAisen
import SwiftData
import LaTeXSwiftUI



struct PolynomialEquationPage: View {
    
    /* ----- Propriétés ----- */
    
    @Environment(\.modelContext) private var modelContext
    @Query var saves: [PolynomialEquation]
    @StateObject var newPolynomial = PolynomialEquationVM()
    var polynomialMods: [ElementDeSelecteur]
    @State var polynomialMod: ElementDeSelecteur
    
    
    
    /* ----- Init ----- */
    
    init() {
        self.polynomialMods = [ElementDeSelecteur(clé: "Calculer avec n"), ElementDeSelecteur(clé: "Calculer avec p et q")]
        self._polynomialMod = State(initialValue: self.polynomialMods[0])
    }
    
    
    
    /* ----- Vue ----- */
    
    var body: some View {
        TypicalPage(title: Pages().polynomialEquation.clé, newCalculation: newPolynomial, saves: saves, minimumSavesCellSize: 250) {
            inputs
        } results: {
            CelluleResultat(
                description: newPolynomial.displayLabel(),
                résultat: newPolynomial.displayResult()
            )
        } savesSection: {
            ForEach(saves) { save in
                Cellule(alignement: .center, largeurMax: .infinity) {
                    LaTeX(displaySavedLabel(save: save))
                        .foregroundStyle(Color.texteSecondaire)
                    
                    Text(displaySavedResult(save: save))
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    
    var inputs: some View {
        VStack(spacing: 16) {
            SelecteurDeroulant(options: polynomialMods, selection: $polynomialMod)
            
            HStack(spacing: 16) {
                switch newPolynomial.mode {
                case .n:
                    ChampDeTexte(label: "a", entréeNumérale: $newPolynomial.a)
                    ChampDeTexte(label: "b", entréeNumérale: $newPolynomial.b)
                    ChampDeTexte(label: "n", entréeNumérale: $newPolynomial.n)
                case .pq:
                    ChampDeTexte(label: "a", entréeNumérale: $newPolynomial.a)
                    ChampDeTexte(label: "b", entréeNumérale: $newPolynomial.b)
                    ChampDeTexte(label: "p", entréeNumérale: $newPolynomial.p)
                    ChampDeTexte(label: "q", entréeNumérale: $newPolynomial.q)
                }
            }
        }
        .onChange(of: polynomialMod) { _, _ in
            switch polynomialMod.clé {
            case "Calculer avec n": self.newPolynomial.mode = .n
            case "Calculer avec p et q": self.newPolynomial.mode = .pq
            default: self.newPolynomial.mode = .n
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func displaySavedLabel(save: PolynomialEquation) -> String {
        switch save.mode {
        case .n: return "$x^{\(save.a ?? 0)} ≡ \(save.b ?? 0)[\(save.n ?? 0)]$"
        case .pq: return "$x^{\(save.a ?? 0)} ≡ \(save.b ?? 0)[\(save.p ?? 0) \\times \(save.q ?? 0)]$"
        }
    }
    
    func displaySavedResult(save: PolynomialEquation) -> String {
        switch save.mode {
        case .n:
            let primeFactor = PrimeFactorsVM(n: save.n!)
            guard !primeFactor.factors.hasDuplicates() else { return "Pas de solution !" }
        case .pq:
            guard save.p!.isPrime() && save.q!.isPrime() else { return "Pas de solution !" }
        }
        return "x = \(save.result)"
    }
}





#Preview {
    PolynomialEquationPage()
}
