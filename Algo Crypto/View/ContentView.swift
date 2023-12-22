//
//  ContentView.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import SwiftUI
import SwiftData
import LaTeXSwiftUI
import CIUAisen



struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    let pages: Pages
    
    
    init() {
        self.pages = Pages()
    }
    

    var body: some View {
        Navigateur(largeur: 300, pageAccueil: pages.euclidAlgo, groupes: pages.pageGroups)
        .tint(.cyan)
    }
}



#Preview {
    ContentView()
}
