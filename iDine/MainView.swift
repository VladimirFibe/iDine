//
//  MainView.swift
//  iDine
//
//  Created by Color Lines on 6/21/23.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            ContentView().tabItem { Label("Menu", systemImage: "list.dash") }.tag(1)
            OrderView().tabItem { Label("Order", systemImage: "square.and.pencil") }.tag(2)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Order())
}
