//
//  GameMagic.swift
//  loremipsum
//
//  Created by raj vaya on 29/01/22.
//

import Foundation
import UIKit
class GameManager : ObservableObject {
    
    
    @Published  var grid : [[Cell]] =
                           [[Cell(),Cell(),Cell(),Cell(),Cell()],
                           [Cell(),Cell(),Cell(),Cell(),Cell()],
                           [Cell(),Cell(),Cell(),Cell(),Cell()],
                           [Cell(),Cell(),Cell(),Cell(),Cell()],
                           [Cell(),Cell(),Cell(),Cell(),Cell()],
                           [Cell(),Cell(),Cell(),Cell(),Cell()]];
    @Published var showToast:Bool = false
    @Published var gameEnded:Bool = false
    @Published var isWin:Bool = false
    @Published var message:String = ""
    
    @Published var keyBoardLayout = [
        [
            Keys(text: "Q"), Keys(text: "W"), Keys(text: "E"), Keys(text: "R"), Keys(text: "T"), Keys(text: "Y"), Keys(text: "U"), Keys(text: "I"), Keys(text: "O"), Keys(text: "P"),
        
        ],
        [
            Keys(text: "A"), Keys(text: "S"), Keys(text: "D"), Keys(text: "F"), Keys(text: "G"), Keys(text: "H"), Keys(text: "J"), Keys(text: "K"), Keys(text: "L")
        ],
        [
            Keys(text: "ENTER"), Keys(text: "Z"), Keys(text: "X"), Keys(text: "C"), Keys(text: "V"), Keys(text: "B"), Keys(text: "N"), Keys(text: "M"),Keys(text: "back"),
        ],
    
    
    ]

    
    
    
    
    
    

    var currentRow = 0;
    var currentCell = 0
    var word = "";
    var resultGrid = "";
    var wordoftheday : String = Words().getRandomWord();
    
    var selectedKeys : [(row:Int,col:Int)] = [];

    
    func toggleToast() {
        self.showToast = false
    }
    
    
    func resetGame() {
        
        
        self.grid = [[Cell(),Cell(),Cell(),Cell(),Cell()],
                             [Cell(),Cell(),Cell(),Cell(),Cell()],
                             [Cell(),Cell(),Cell(),Cell(),Cell()],
                             [Cell(),Cell(),Cell(),Cell(),Cell()],
                             [Cell(),Cell(),Cell(),Cell(),Cell()],
                             [Cell(),Cell(),Cell(),Cell(),Cell()]];
        
        
        self.keyBoardLayout = [
           [
               Keys(text: "Q"), Keys(text: "W"), Keys(text: "E"), Keys(text: "R"), Keys(text: "T"), Keys(text: "Y"), Keys(text: "U"), Keys(text: "I"), Keys(text: "O"), Keys(text: "P"),
           
           ],
           [
               Keys(text: "A"), Keys(text: "S"), Keys(text: "D"), Keys(text: "F"), Keys(text: "G"), Keys(text: "H"), Keys(text: "J"), Keys(text: "K"), Keys(text: "L")
           ],
           [
               Keys(text: "ENTER"), Keys(text: "Z"), Keys(text: "X"), Keys(text: "C"), Keys(text: "V"), Keys(text: "B"), Keys(text: "N"), Keys(text: "M"),Keys(text: "back"),
           ],
           [
               Keys(text: "ENXTER"), Keys(text: "Z"), Keys(text: "X"), Keys(text: "C"), Keys(text: "V"), Keys(text: "B"), Keys(text: "N"), Keys(text: "M"),Keys(text: "back"),
           ],
       
       
       ]
        
        self.currentRow = 0;
        self.currentCell = 0
        self.word = "";
        self.wordoftheday = Words().getRandomWord();
        self.gameEnded = false
        self.isWin = false
        self.showToast = false
        self.message = ""
        
    }
    
    
    func buttonClicked(item:String,col:Int,row:Int)  {
        if(gameEnded) { return;}
        if(self.currentCell < 5 && self.currentRow < 6 && item.count == 1){
            selectedKeys.append((row:row,col:col));
            if(currentCell != 0){
                self.grid[self.currentRow][self.currentCell-1].isAnimated = true;}
        self.grid[self.currentRow][self.currentCell] = Cell(text: item);
        self.word+=item;
        self.currentCell+=1;
        }
        
        else if(self.word.count == 5 && self.currentRow < 6 && item == "ENTER") {
            submitWord();
        }
        
        else if(item == "back" && self.word.count > 0){
            
            clearCell()
            selectedKeys.removeLast();

        }
        else{
            message = "No No No...";
            showToast = true
        }
    }

    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isCorrect(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    
    func clearCell(){
        
            
                self.grid[self.currentRow][self.currentCell-1] = Cell();
                self.word.removeLast();
                self.currentCell -= 1;
                
            
    }
    
    
    func updateKeyBoardColor(color : KeyColor,row :Int,col:Int) -> Void {
        if(keyBoardLayout[row][col].keyColor != KeyColor.Green){
        keyBoardLayout[row][col].keyColor = color
        }
        }
    
    
    
    func copyResult() {
        
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = "Sasta Wordle \n Word : \(wordoftheday)\n\n"+resultGrid

    }
    
    func submitWord(){
    
        
        print(wordoftheday)
        if(Words().isValidWord(word: self.word))
        {
            self.grid[self.currentRow][self.currentCell-1].isAnimated = true;
            for (index, char)in self.word.enumerated()
            {
                
                print("character = \(char) \(index)")
                
                let lowChar = char.lowercased();
                let selectedKey = selectedKeys[index] ;
                
                if(wordoftheday.contains(lowChar)){
                    let wodChar  = Array(self.wordoftheday)[index];
                    if( String(wodChar) == String(lowChar)) {
                        self.grid[self.currentRow][index].cellColor = CellColor.Green
                        updateKeyBoardColor(color: KeyColor.Green, row: selectedKey.row, col: selectedKey.col)
                        resultGrid += "🟢"
        
                    }
                    else {
                        self.grid[self.currentRow][index].cellColor = CellColor.Yellow
                        updateKeyBoardColor(color: KeyColor.Yellow, row: selectedKey.row, col: selectedKey.col)
                        resultGrid += "🟡"

                    }
                }
                
                else {
                    self.grid[self.currentRow][index].cellColor = CellColor.Black
                    updateKeyBoardColor(color: KeyColor.Black, row: selectedKey.row, col: selectedKey.col)
                    resultGrid += "⚪️"

                }
                
            }

            resultGrid += "\n"
            selectedKeys.removeAll()
            if( wordoftheday == word.lowercased()) {
                
                self.isWin = true;
                self.gameEnded = true;
                self.message = "You Won";
                showToast = true
                
            }
            else {
            //Moves To Next Row and Submit The Word
                
            if(currentRow != 5){
            self.currentRow += 1;
            self.currentCell = 0;
            self.word = "";
                }
                
                else {
                    gameEnded = true
                }
                
                
            }
           
            
        }
        else {
            
            print("NOT IN Word List")
            self.message = "Not in word list";
            showToast = true
        }
        
    }
    
    

    
    
}
