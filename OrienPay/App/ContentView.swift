//
//  ContentView.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 24.06.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("Auth") var auth: Bool = false
    @AppStorage("Splash") var splashActive: Bool = true
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                    }
            }
        }
        .tint(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
