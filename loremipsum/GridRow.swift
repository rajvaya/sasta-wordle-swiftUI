//
//  GridRow.swift
//  loremipsum
//
//  Created by raj vaya on 28/01/22.
//

import SwiftUI

struct GridRow: View {
    
    @EnvironmentObject var gameManager:GameManager
     var data:[Cell];
        
        var body: some View {
            HStack{
                ForEach(data,  id: \.id ) { item in
                    CellView(text : item.text, color: item.cellColor , isAnimated : item.isAnimated , item : item)
                    
                if item != data.last {
                    Spacer()}

                
            }}
            .padding(.horizontal,24)

    }
}

//struct GridRow_Previews: PreviewProvider {
//    static var previews: some View {
//        GridRow(data: Binding.constant([Cell(text: "A", cellColor: CellColor.White),Cell(text: "A", cellColor: CellColor.White),Cell(text: "A", cellColor: CellColor.White),Cell(text: "A", cellColor: CellColor.White)]))
//    }
//}



struct CellView: View {
    
    var text:String;
    var color : CellColor;
    var isAnimated:Bool;
    var item : Cell;
    @State var animationAmount : CGFloat = 1.2 ;
    @State private var shouldAnimate = false
    @State private var animated = false


    
    func getColor(color : CellColor) -> Color {

        switch color {
        case CellColor.Green:
           return Color.green
        case CellColor.White:
            return Color.white
        case CellColor.Yellow:
            return Color.yellow
        case CellColor.Black:
            return Color.gray
       
        }

    }
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor( color == CellColor.White ? Color.black: Color.white)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 70, maxHeight: 70)
            .aspectRatio(1, contentMode: .fill)
            .background(getColor(color:color))
            .fixedSize(horizontal: true, vertical: false)
            .border(Color.gray, width: color != CellColor.White ? 0:  (text != "" ? 3 : 1))
            .scaleEffect(self.shouldAnimate ? self.animationAmount : 1)
            .onAppear {

             
                if(text != "" && !isAnimated ) {
                    let animation = Animation.easeInOut(duration: 0.3).repeatCount(1, autoreverses: true)
                                   withAnimation(animation) {
                                       self.shouldAnimate.toggle()
                                   }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ) {
                                       withAnimation(animation) {
                                           self.shouldAnimate.toggle()
                                       }
                                   }
                    animated.toggle()
                }
                
    
                
                
            }
                

            }
    }
            
