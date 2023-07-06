//
//  SplashView.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 24.06.2023.
//

import SwiftUI

struct SplashView: View {
    var logoWidth:CGFloat = CGFloat(100)
    var logoHeight:CGFloat = CGFloat(100)
    @State var offy:CGFloat = 150
    @State var opp: Double = 0
    @State var showCirc: Bool = false
    var body: some View {
        ZStack{
            Color("BlueLogo").ignoresSafeArea()
            VStack{
                ZStack{
                    Circle().fill(Color.white)
                        .opacity(showCirc ? 0.1 : 0)
                        .frame(width: screenWidth-10, height: screenHeight-10)
                    Circle().fill(Color.white).opacity(showCirc ? 0.1 : 0).frame(width: screenWidth - 100, height: screenHeight - 100).opacity(0.5)
                    Circle().fill(Color.white).opacity(showCirc ? 0.1 : 0).frame(width: screenWidth - 200, height: screenHeight - 200).opacity(0.9)
                    Image("logoIcon")
                        .resizable()
                        .frame(width: logoWidth, height: logoHeight)
                        .offset(y:offy)
                    
                }
            }
            .onAppear{
                withAnimation(.easeIn(duration: 1)) {
                    offy = 0
                }
                withAnimation(.easeOut(duration: 1).delay(1)){
                    showCirc = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
