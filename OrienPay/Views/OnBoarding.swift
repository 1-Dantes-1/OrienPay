//
//  OnBoarding.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 24.06.2023.
//

import SwiftUI

struct OnBoarding: View {
    var body: some View {
        ZStack{
            Color("BlueLogo").ignoresSafeArea()
            VStack{
                HStack{
                    Rectangle().fill(Color.white).frame(width: 60, height: 5).cornerRadius(15)
                    Rectangle().fill(Color.gray).frame(width: 60, height: 5).cornerRadius(15)
                    Rectangle().fill(Color.gray).frame(width: 60, height: 5).cornerRadius(15)
                    Rectangle().fill(Color.gray).frame(width: 60, height: 5).cornerRadius(15)
                    Rectangle().fill(Color.gray).frame(width: 60, height: 5).cornerRadius(15)
                }
                .padding(.horizontal,10)
                Spacer()
                VStack(alignment:.center){
                    Image("Bitcoin")
                        .resizable()
                        .scaledToFit()
                    Text("Оплачиваете услуги без \n\t    выхода из дома")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.medium)
                }
                Spacer()
                Button{
                    
                } label:{
                    Text("Войти")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                .frame(width: screenWidth - 40, height: 50)
                .background(Color.white)
                .padding(.bottom,1)
                .cornerRadius(15)
            }
        }
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
