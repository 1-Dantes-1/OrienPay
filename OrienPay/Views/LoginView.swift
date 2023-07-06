//
//  LoginView.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 24.06.2023.
//

import SwiftUI

struct LoginView: View {
    @State var phoneNum: String = "+992"
    @ObservedObject var userModel = UserModel()
    @State var invalidOpacity = true
    @State var sheet: Bool = false
    @AppStorage("Auth") var auth: Bool = false
    @AppStorage("Splash") var splash: Bool = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("Добро Пожаловать")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.black.opacity(0.7))
                Text("Введите свой номер телефона, чтобы продолжить")
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: screenWidth - 40, height: 40,alignment: .leading)
                    .padding(.bottom,20)
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .frame(width: screenWidth, height: 180)
            TextField("+992", text: $phoneNum).padding()
                .foregroundColor(.black)
                .frame(width: screenWidth - 40, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
            HStack{
                Text("Неправильный номер")
                    .font(.subheadline)
                    .frame(width: screenWidth - 70, height: 20, alignment: .leading)
                    .foregroundColor(.red)
                    .opacity(invalidOpacity ? 0 : 1)
            }
            HStack{
                Text("Если у вас нету аккаунта то?")
                    .font(.footnote)
                Text("Зарегистрируйтесь")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            .padding(.top, 40)
            Spacer()
            Button{
                if checkPhoneNumber(phoneNum: phoneNum){
                    userModel.currentUser = userModel.findUserByPhoneNumber(withPH: phoneNum)
                    if !userModel.currentUser.authorized{
                        print("Authorize \(userModel.currentUser.phone_numbers)")
                        sheet.toggle()
                    }
                    else{
                        userModel.currentUser = userModel.findUserByPhoneNumber(withPH: phoneNum)
                        splash = true
                        auth = true
                    }
                }
                else{
                    withAnimation {
                        invalidOpacity.toggle()
                    }
                }
            } label:{
                Text("Войти")
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
        .sheet(isPresented: $sheet) {
            SignUpView(sheetActive: $sheet, user:userModel.currentUser)
                .interactiveDismissDisabled()
        }
    }
    func checkPhoneNumber(phoneNum: String) -> Bool{
        if phoneNum.count == 13{
            return true
        }
        return false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserModel())
    }
}
