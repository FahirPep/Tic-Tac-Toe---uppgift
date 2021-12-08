//
//  ViewController.swift
//  TicTacToe
//
//  Created by Fahir Pepelar on 2021-12-08.
//

import UIKit

class ViewController: UIViewController
{
    //Could use Boolean or Int to determine whose turn it is. But enum is easier and more reader-friendly
    enum Turn {
        case Nought
        case Cross
    }
    
    //Button for every square on the board
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    //Keeps track on whose turn it is to go first in each game. Flips every time a game ends as well.
    var firstTurn = Turn.Cross
    //Flips each time a tile is placed in the square
    var currentTurn = Turn.Cross
    
    //Constants strings. These will be placed on the board.
    var NOUGHT = "O"
    var CROSS = "X"
    
    //Array of buttons
    var board = [UIButton]()
    
    //Scoreboard
    var noughtsScore = 0
    var crossesScore = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initBoard()
        
    }
    func initBoard()
    {
        //Adds new element at the end of the array
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }

    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            crossesScore += 1
            resultAlert(title: "Crosses win!")
            
        }
        
        if checkForVictory(NOUGHT) {
            noughtsScore += 1
            resultAlert(title: "Noughts win!")
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s :String) -> Bool
    {
        //Checking to see if horizontal victory has the same symbol
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s)
        {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s)
        {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        //Checking to see if vertical victory has the same symbol
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s)
        {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s)
        {
            return true
        }
        
        //Checking to see if diagonal victory has the same symbol
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s)
        {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s)
        {
            return true
        }
    
        //If no winner, resultAlert will alert "Draw"
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        //"let message" writes out the score between "O" and "X", as well as if it was a win or a draw
        let message = "\nNougths " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in
            self.resetBoard()
        }))
        
        self.present(ac, animated: true)
    }
    
    func resetBoard()
    {
        //Reseting the buttons to nil
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        //Flipping the first turn, regardless of result. If first turn WAS nought, then it flips to Cross as first turn.
        if(firstTurn == Turn.Nought)
        {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        //Same principle as the above if-statement
        else if(firstTurn == Turn.Cross)
        {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        
        currentTurn = firstTurn
    }
    //This function checks if there is an empty space on the board
    func fullBoard() -> Bool
    {
        for button in board
        {
            //If an empty space is found
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        
        return true
    }
    
    func addToBoard(_ sender: UIButton)
    {
        //If there is nothing in the buttons tile
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == Turn.Nought)
            {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            
            else if(currentTurn == Turn.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            //Removes animation when clicking on a button with an existing "O" or "X"
            sender.isEnabled = false
        }
    }
    
}

