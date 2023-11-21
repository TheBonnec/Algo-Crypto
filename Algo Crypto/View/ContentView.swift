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
    @State var selectedPage: PageInfo<AnyView>
    
    let pages: Pages
    
    init() {
        self.pages = Pages()
        self.selectedPage = self.pages.defaultPage
    }
    

    var body: some View {
        NavigationSplitView {
            ZStack {
                Color(.fondTertiaire)
                    .ignoresSafeArea()
                
                List {
                    ForEach(pages.pageGroups) { pageGroup in
                        Section(pageGroup.groupName) {
                            ForEach(pageGroup.pages) { page in
                                Button {
                                    self.selectedPage = page
                                } label: {
                                    HStack {
                                        Text("\(page.pageName)")
                                            
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .background(cellBackground(pageInfo: page))
                                    .cornerRadius(8)
                                }                                
                            }
                        }
                    }
                }
                
                
                /*
                List {
                    ForEach(pages.pageGroups) { pageGroup in
                        Section(pageGroup.groupName) {
                            ForEach(pageGroup.pages) { page in
                                NavigationLink {
                                    AnyView(page.destination)
                                        .padding(.vertical)
                                } label: {
                                    Text(page.pageName)
                                }
                            }
                        }
                    }
                }
                */
                
                .navigationTitle("Algo Crypto")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(removing: .sidebarToggle)
            }
        } detail: {
            selectedPage.destination()
                .background(Color.fondSecondaire)
        }
        .tint(.cyan)
    }
    
    
    func cellBackground(pageInfo: PageInfo<AnyView>) -> Color? {
        if self.selectedPage.page == pageInfo.page {
            return Color.elémentSecondaire
        }
        return nil
    }
}



#Preview {
    ContentView()
}
