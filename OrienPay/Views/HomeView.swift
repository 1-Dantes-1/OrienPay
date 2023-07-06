//
//  HomeView.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 29.06.2023.
//

import SwiftUI

struct HomeView: View {
    @State var search: String = ""
    @ObservedObject var userModel = UserModel()
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(.systemGray4).opacity(0.7).ignoresSafeArea()
                VStack{
                    HStack{
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 40,height: 40)
                        Text("\(userModel.currentUser.name) \(userModel.currentUser.surname)")
                            .foregroundColor(.black.opacity(0.8))
                            .font(.headline.bold())
                        Spacer()
                        Image(systemName: "heart").resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                        Image(systemName: "bell").resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                    }
                    .padding()
                    .frame(width: screenWidth - 20, height: 50)
                    Spacer().frame(height: 30)
                    VStack(spacing:0){
                        HStack{
                            Spacer()
                            Text("Все услуги")
                            Image(systemName: "chevron.down.circle.fill")
                        }
                        .padding()
                        TextField("Поиск", text: $search).padding()
                            .frame(width: screenWidth - 50, height: 40)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal,10)
                        Spacer().frame(height: 10)
                        Group{
                            ForEach(buttonsHome, id: \.self){ button in
                                NavigationLink {
                                    
                                } label: {
                                    HStack{
                                        Image(systemName: button.image)
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .padding(.horizontal,10)
                                            .foregroundColor(Color(button.color))
                                        Text("\(button.text)")
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .frame(width: screenWidth-50,height: 50)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(25)
                                    .padding(.vertical,10)
                                }
                            }
                        }
                        .listStyle(.plain)
                        
                        Spacer()
                        
                    }.frame(width: screenWidth-20, height: screenHeight - 450)
                        .background(.white.opacity(0.9))
                        .cornerRadius(15)
                    Spacer().frame(height: 240)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
