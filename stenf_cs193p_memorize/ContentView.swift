//
//  ContentView.swift
//  stenf_cs193p_memorize
//
//  Created by Utente on 04/05/25.
//

import SwiftUI

struct ContentView: View {
    let emojisSet =    ["🐻", "🐶", "🐭", "🐰", "🦁", "🐔", "🦆", "🐴", "🦅", "🦧", "🐳", "🌞"]
    let minCardCount = 4
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum:70))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojisSet[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var cardCountAdjusters:some View{
        HStack{
            cardRemuver
            Spacer()
            cardAdder
        }
        .foregroundColor(.blue)
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset:Int, symbol:String) -> some View {
        Button(
            action: { cardCount+=offset},
            label: {
                Image(systemName: symbol)
            }
        ).disabled(
            (cardCount+offset) < 4 ||
            (cardCount+offset) > emojisSet.count
        )
    }
    
    var cardRemuver: some View {
        cardCountAdjuster(by: -4, symbol: "minus.square.fill")
    }
    
    var cardAdder: some View{
        cardCountAdjuster(by: +4, symbol: "plus.square.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUP = false
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUP ? 1: 0)
            
            base.fill().opacity(isFaceUP ? 0: 1)
            
        }.onTapGesture {
            print("TAB")
            isFaceUP.toggle()
        }
    }
}

#Preview {
    ContentView()
}


