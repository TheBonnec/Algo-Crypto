//
//  CelluleResultat.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 20/12/2023.
//

import SwiftUI
import LaTeXSwiftUI
import CIUAisen


struct CelluleResultat: View {
    
    /* ----- Attributs ----- */
    
    var description: String
    var résultat: String?
    var résultatComplexe: AnyView?
    var typeAffichage: TypeAffichage
    
    
    
    /* ----- Inits ----- */
    
    init(description: String, résultat: String) {
        self.description = description
        self.résultat = résultat
        self.résultatComplexe = nil
        self.typeAffichage = .simple
    }
    
    init<Contenu: View>(description: String, @ViewBuilder résultatComplexe: () -> Contenu) {
        self.description = description
        self.résultat = nil
        self.résultatComplexe = AnyView(résultatComplexe())
        self.typeAffichage = .détaillé
    }
    
    
    
    /* ----- Vues ----- */
    
    var body: some View {
        Group {
            switch typeAffichage {
            case .simple: celluleSimple
            case .détaillé: celluleDétaillé
            }
        }
    }
    
    
    var celluleSimple: some View {
        CelluleBleu(alignement: .center, largeurMax: .infinity) {
            LaTeX(description)
                .foregroundStyle(Color.texteSecondaire)
                .padding(.vertical, 4)
            
            LaTeX(résultat!)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
        }
    }
    
    
    var celluleDétaillé: some View {
        CelluleBleu(alignement: .center, largeurMax: .infinity) {
            LaTeX(description)
                .foregroundStyle(Color.texteSecondaire)
                .padding(.vertical, 4)
            
            résultatComplexe
                .padding(.bottom, 8)
        }
    }
    
    
    
    /* ----- Enum ----- */
    
    enum TypeAffichage {
        case simple, détaillé
    }
}





#Preview {
    CelluleResultat(description: "pgcd(2, 4)", résultat: "4")
        .padding(20)
}
