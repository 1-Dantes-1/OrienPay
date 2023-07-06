//
//  SettingsView.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 5.07.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("Auth") var auth: Bool = false
    @AppStorage("Splash") var splash: Bool = true
    @State var togller = false
    @ObservedObject var userModel = UserModel()
    var body: some View {
        NavigationStack{
            List {
                ForEach(buttonsSettings, id:\.hashValue){ button in
                    NavigationLink{
                        Form{
                            ForEach(button.destination.destoggles, id:\.self){ tog in
                                Section {
                                    Toggle(isOn: $togller) {
                                        Text("\(tog.text)")
                                    }
                                } header: {
                                    Text("\(tog.header)")
                                }
                                
                            }
                            ForEach(button.destination.desbuttons, id:\.self){ but in
                                if but.text == "Изменить профиль"{
                                    Section{
                                        NavigationLink{
                                            EditUserView(user: userModel.currentUser)
                                        } label:{
                                            Text("Изменить профиль")
                                        }
                                    } header: {
                                        Text(but.header!)
                                    }
                                }
                                else if but.text == "Выйти"{
                                    Section{
                                        Button{
                                            splash = true
                                            auth = false
                                        } label:{
                                            Text("Выйти")
                                                .foregroundColor(.red)
                                        }
                                    } header: {
                                        Text(but.header!)
                                    }
                                }
                                else{
                                    Section{
                                        NavigationLink{
                                            
                                        } label:{
                                            Text("\(but.text ?? "No Button")")
                                        }
                                    } header: {
                                        Text(but.header!)
                                    }
                                }
                            }
                            if button.destination.destext != ""{
                                Text("\(button.destination.destext)")
                            }
                        }
                    } label: {
                        Text(button.text)
                    }
                    
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
