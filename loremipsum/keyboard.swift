//
//  keyboard.swift
//  loremipsum
//
//  Created by raj vaya on 29/01/22.
//

import SwiftUI


let keyboardLayout = [[
    "Q","W","E","R","T","Y","U","I","O","P"
],[
    "A","S","D","F","G","H","J","K","L"
],[
    "ENTER","Z","X","C","V","B","N","M","back"
]]
struct keyboard: View {
    
    @EnvironmentObject var gameManager:GameManager
    
    func getColor(color : KeyColor) -> Color {

        switch color {
        case KeyColor.Green:
           return Color.green
        case KeyColor.Grey:
            return Color("customGrey")
        case KeyColor.Yellow:
            return Color.yellow
        case KeyColor.Black:
            return Color.gray
       
        }

    }

    
    var body: some View {
        
        VStack {
               ForEach(0..<gameManager.keyBoardLayout.count) { row in
                 HStack {
                   ForEach(0..<gameManager.keyBoardLayout[row].count) { col in
                    let item = gameManager.keyBoardLayout[row][col]
                     Button {
                         gameManager.buttonClicked(item:item.text,col: col,row: row)
                     } label: {
                         KeyboardButton(text: item.text , color : getColor(color: item.keyColor))
                     }
                   }
                 }
               }
        } .padding(.horizontal,24)
           }
        
}

struct keyboard_Previews: PreviewProvider {
    static var previews: some View {
        keyboard()
    }
}


struct KeyboardButton: View {

    let text : String
    let color : Color
  var body: some View {
      
    
    
      Group {
          switch text {
           case "ENTER":
            Image(systemName: "return.right")
           case "back":
             Image(systemName: "delete.backward")
            default :
              Text(text)
              
          }
          }
          .foregroundColor(color == Color("customGrey") ? .black : .white).padding(.vertical)
          .frame(maxWidth: .infinity)
          .background(color)
          .cornerRadius(4)
          
      
    
  }

}
