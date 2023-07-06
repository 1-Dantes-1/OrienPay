//
//  CodeReceiveView.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 24.06.2023.
//

import SwiftUI

struct CodeReceiveView: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing:0) {
                Text("Подтвердите номер")
                    .font(.title)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.black.opacity(0.7))
                Text("Код отправлен на")
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: screenWidth - 40, height: 40,alignment: .leading)
                    .padding(.bottom,20)
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .frame(width: screenWidth, height: 180)
            HStack{
                Rectangle().fill(Color.gray).frame(width: 40, height: 50)
                    .cornerRadius(15).opacity(0.5)
                Rectangle().fill(Color.gray).frame(width: 40, height: 50)
                    .cornerRadius(15).opacity(0.5)
                Rectangle().fill(Color.gray).frame(width: 40, height: 50)
                    .cornerRadius(15).opacity(0.5)
                Text("-")
                    .font(.title)
                Rectangle().fill(Color.gray).frame(width: 40, height: 50)
                    .cornerRadius(15).opacity(0.5)
                Rectangle().fill(Color.gray).frame(width: 40, height: 50)
                    .cornerRadius(15).opacity(0.5)
                Rectangle().fill(Color.gray).frame(width: 40, height: 50)
                    .cornerRadius(15).opacity(0.5)
            }
            VStack{
                Text("Не получили код?")
                Text("Отправить")
                    .foregroundColor(.blue)
            }
            .padding(.vertical, 20)
            Spacer()
        }
    }
}

struct CodeReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        CodeReceiveView()
    }
}
