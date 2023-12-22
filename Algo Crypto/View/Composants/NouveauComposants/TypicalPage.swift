//
//  TypicalPage.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/12/2023.
//

import SwiftUI
import SwiftData
import CIUAisen


struct TypicalPage<Calculation: CalculationVMProtocol, Save: PersistentModel, V: View, U: View, W: View>: View {
    
    /* ----- Attributs ----- */
    
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var newCalculation: Calculation
    var title: String
    var saves: [Save]
    var minimumSavesCellSize: CGFloat
    var inputs: V
    var results: U
    var savesSection: W
    
    
    
    /* ----- Inits ----- */
    
    init(title: String, newCalculation: Calculation, saves: [Save], minimumSavesCellSize: CGFloat, @ViewBuilder inputs: () -> V, @ViewBuilder results: () -> U, @ViewBuilder savesSection: () -> W) {
        self.title = title
        self.newCalculation = newCalculation
        self.saves = saves
        self.minimumSavesCellSize = minimumSavesCellSize
        self.inputs = inputs()
        self.results = results()
        self.savesSection = savesSection()
    }
    
    
    
    /* ----- Vues ----- */
    
    var body: some View {
        Page(titre: title.localized()) {
            // Inputs
            CelluleEntrees {
                inputs
            } actionSauvegarder: {
                self.save()
            } actionReinitialiser: {
                self.reset()
            }
            
            // Results
            results
            
            
            // Saves
            if saves.count > 0 {
                HStack(alignment: .bottom) {
                    Text("SavedCalculations".localized())
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Bouton(type: .destructeurPrimaire, label: "Clean".localized()) {
                        deleteAllSaves()
                    }
                }
                .padding(.top, 32)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumSavesCellSize), spacing: 24)], spacing: 24) {
                    savesSection
                }
            } else {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("NoCalculation".localized())
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.texteSecondaire)
                        Spacer()
                    }
                }
                .frame(height: 200)
            }
        }
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func save() {
        guard self.newCalculation.saveModel(context: modelContext) else { return }
        self.newCalculation.resetInputs()
    }
    
    func deleteAllSaves() {
        for save in saves {
            modelContext.delete(save)
        }
    }
    
    func reset() {
        self.newCalculation.resetInputs()
    }
}





#Preview {
    TypicalPage(title: Pages().euclidAlgo.clé, newCalculation: EuclidAlgoVM(), saves: [EuclidAlgo()], minimumSavesCellSize: 200) {
        HStack(spacing: 16) {
            ChampDeTexte(label: "a", entréeNumérale: .constant(0))
            ChampDeTexte(label: "b", entréeNumérale: .constant(0))
        }
    } results: {
        CelluleResultat(description: "pgcd(1, 3)", résultat: "1")
    } savesSection: {
        Cellule(alignement: .center, largeurMax: .infinity) {
            Text("pgcd(2,4)")
                .foregroundStyle(Color.texteSecondaire)
            
            Text("2")
                .font(.title2)
                .fontWeight(.bold)
        }
    }

}
