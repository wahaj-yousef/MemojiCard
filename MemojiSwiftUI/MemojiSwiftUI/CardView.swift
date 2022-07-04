//
//  CardView.swift
//  MemojiSwiftUI
//
//  Created by wahaj on 03/07/2022.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var cardInfo : CardInfo

    @State private var backgroundColor: Color = .clear

    var body: some View {
        ZStack {
            Color.white .frame(width: 303, height: 455.6, alignment: .center).cornerRadius(20)
            VStack{
                
                Image(uiImage: cardInfo.Memoji)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                VStack(alignment: .leading){
                    Text(cardInfo.fullName)
                    .font(.title)
                    .fontWeight(.black)
                    Text(cardInfo.Nationality)
                        .font(.subheadline)
                    .fontWeight(.bold)
                   
                }
                Divider().foregroundColor(.white)
                VStack(alignment: .leading,spacing: 10){
                    Text("Intersts: \(cardInfo.interset)")
                        .font(.callout)
                    Divider().foregroundColor(.white)
                    Label(title: {Text("\(cardInfo.email)")}, icon: {Image(systemName: "envelope.fill")})
                        .font(.callout)
                    Label(title: {Text("\(cardInfo.phoneNo)")}, icon: {Image(systemName: "phone.fill")})
                        .font(.callout)
              
               
              
                }.padding()
                
            }
            .frame(width: 303, height: 455.6, alignment: .center)
            .background(CardBackground(color: cardInfo.BgColor))
            .cornerRadius(20)
            .foregroundColor(cardInfo.TextColor)
            .onAppear(){
                self.setAverageColor()

        }
        }
        
     

        
    }
    
    
    func CardBackground(color: Color) -> LinearGradient{
        return LinearGradient(gradient:Gradient(colors: [color,color.opacity(0.5)]),startPoint: .top, endPoint: .bottom)
    }
    private func setAverageColor() {
        let uiColor = cardInfo.Memoji.averageColor ?? .clear
         backgroundColor = Color(uiColor)
     }
    
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()           .previewLayout(.sizeThatFits)

    }
}
