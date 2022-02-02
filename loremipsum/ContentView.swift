//
//  ContentView.swift
//  loremipsum
//
//  Created by raj vaya on 28/01/22.
//

import SwiftUI
import SimpleToast

struct ContentView: View {
    
    
    
    @StateObject var gameManager = GameManager()
    
    @State var data = [["A","B","C","D","E"],["F","G","H","I","J"],["K","L","M","N","O"],["P","Q","R","S","T"],["U","V","W","X","Y"],["X","X","X","X","X"]]
    
    
    @State var initData:Array<Array<Cell>> =
    [[Cell(text: "A", cellColor: CellColor.Green),
    Cell(text: "B",cellColor:CellColor.Yellow),
    Cell(text: "A",cellColor: CellColor.Black),
    Cell(text: "A",cellColor: CellColor.White),
    Cell()],
    ]
    
    
    let toastOptions = SimpleToastOptions(alignment: .center, hideAfter: 2, showBackdrop: false, backdropColor: Color.black, animation: .default, modifierType: .slide)
 
    
    var body:
    
    some View {
        ZStack{
        VStack{
        VStack(spacing: 16){
            ForEach(gameManager.grid, id: \.self) { item in
                GridRow(data:item).scaledToFit()
            }
        }
        
        .padding(.top, 32.0)
        Spacer()
        keyboard().environmentObject(gameManager)
        
        
        }
        .simpleToast(isPresented: $gameManager.showToast, options: toastOptions,onDismiss: {
            gameManager.toggleToast();     }) {
          HStack {
        
              Text(gameManager.message)
          }
          .padding()
          .background(Color.gray.opacity(0.8))
          .foregroundColor(Color.white)
          .cornerRadius(10)
      }
            
            if(gameManager.gameEnded) {
                
              
                    VStack{
                        Text(gameManager.isWin ? "You Won 🎉" : "You Lost 😔" )
                            .font(.largeTitle)
                            .foregroundColor(.white);
                HStack{
                    
                    Button(action: {
                        
                        gameManager.resetGame();
                    }) {
                        
                        Text("Reset").scaledToFit()
                        .scaledToFill()
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(12)
                    }
                    
                    Spacer()
                    Button(action: {
                        print("Copy tapped!")
                        gameManager.copyResult();
                    }) {
                        
                        Text("Copy Result").scaledToFit()
                        .scaledToFill()
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(12)
                    }
                
                
                
            }
        
        
                    }.padding( .horizontal,20)
                    .frame(maxWidth: 350, maxHeight: 400, alignment: .center).scaledToFit().background(Color.black.opacity(0.7)).cornerRadius(12)
                
            
                
            }
        
        

    }
    
   
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


