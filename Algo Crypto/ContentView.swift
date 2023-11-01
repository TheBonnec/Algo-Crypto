//
//  ContentView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State var pageToShow: Page = .main
    

    var body: some View {
        switch pageToShow {
        case .main:
            MainViews(page: $pageToShow)
        case .euclid:
            EuclidAlgoView(page: $pageToShow)
        case .extendedEuclid:
            ExtendedEuclidAlgoView(page: $pageToShow)
        case .modulo:
            ModuloView(page: $pageToShow)
        case .congruence:
            CongruenceView(page: $pageToShow)
        }
    }
}



enum Page {
    case main, euclid, extendedEuclid, modulo, congruence
}



#Preview {
    ContentView()
}
