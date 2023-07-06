//
//  SignUpView.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 30.06.2023.
//

import SwiftUI

struct EditUserView: View {
    @ObservedObject var userModel = UserModel()
    @State var errMsg: String = ""
    @State var alert: Bool = false
    @AppStorage("Auth") var auth: Bool = false
    @AppStorage("Splash") var splash: Bool = false
    @State var user: User
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(alignment: .leading){
                    Text("Изменить профиль")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.black.opacity(0.7))
                    Text("Заполните данные которые хотите изменить")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.5))
                        .frame(width: screenWidth - 40, height: 40,alignment: .leading)
                        .padding(.bottom,20)
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .frame(width: screenWidth, height: 150)
                VStack{
                    TextField("Имя", text: $user.name).padding().frame(width: screenWidth - 50, height: 40)
                        .background(.gray.opacity(0.2)).cornerRadius(15)
                    TextField("Фамилия", text: $user.surname).padding().frame(width: screenWidth - 50, height: 40)
                        .background(.gray.opacity(0.2)).cornerRadius(15)
                    TextField("Возраст", text: $user.age).padding().frame(width: screenWidth - 50, height: 40)
                        .background(.gray.opacity(0.2)).cornerRadius(15)
                }
                Spacer()
                Button{
                    if isValid(name: user.name, surname: user.surname, age: user.age){
                            userModel.editUser(user: user)
                            userModel.currentUser = user
                            splash = true
                        dismiss()
                    }
                    else{
                        alert.toggle()
                    }
                } label:{
                    Text("Изменить")
                        .foregroundColor(.white)
                        .frame(width: screenWidth - 20, height: 50)
                        .background(Color.mint)
                        .cornerRadius(15)
                        .padding(.bottom,20)
                }
            }
            .onAppear{
                userModel.fetchData()
            }
            .alert(isPresented: $alert) {
                Alert(title: Text(errMsg))
            }
        }
    }
    func isValid(name:String, surname: String, age: String) -> Bool{
        if name.isEmpty{
            errMsg = "Заполните поле имя"
            return false
        }
        if surname.isEmpty{
            errMsg = "Заполните поле фамилия"
            return false
        }
        if surname.isEmpty{
            errMsg = "Заполните поле возраст"
            return false
        }
        return true
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(user: UserModel().currentUser)
    }
}

