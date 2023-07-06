//
//  OrienPayApp.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 24.06.2023.
//

import SwiftUI

@main
struct OrienPayApp: App {
    @ObservedObject var userModel = UserModel()
    @AppStorage("Auth") var auth: Bool = false
    @AppStorage("Splash") var splashActive: Bool = true
    var body: some Scene {
        WindowGroup {
            if splashActive {
                SplashView()
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                            splashActive = false
                        }
                    }
            }
            else{
                if !auth{
                    LoginView()
                        .environmentObject(UserModel())
                }
                else{
                    ContentView()
                }
            }
        }
    }
}
