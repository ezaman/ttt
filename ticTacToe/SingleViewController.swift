//
//  SingleViewController.swift
//  ticTacToe
//
//  Created by Ehsan Zaman on 4/23/17.
//  Copyright © 2017 Ehsan Zaman. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {
    
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    
    
    let winningCombinations  = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    var playerOneMoves = Set<Int>()
    var playerTwoMoves = Set<Int>()
    var possibleMove = Array<Int>()
    var nextMove: Int? = nil
    var playerTurn = 1
    var allSpaces: Set<Int> = [1,2,3,4,5,6,7,8,9]
    
    
    
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if playerOneMoves.contains(sender.tag) || playerTwoMoves.contains(sender.tag) {
            outcomeLabel.text = "Space already used"
        }else {
            
            if playerTurn % 2 != 0 {
                playerOneMoves.insert(sender.tag)
                //sender.setTitle("X", for: UIControlState.normal)
                sender.setImage(UIImage(named: "ex.png"), for: UIControlState.normal)
                //outcomeLabel.text = "Player 2's Turn"
                
                if isWinner(player: 1) == 0 {
                    
                    let nextMove = playsAI()
                    playerTwoMoves.insert(nextMove)
                    let button = self.view.viewWithTag(nextMove) as! UIButton
                   // button.setTitle("O", for: UIControlState.normal)
                    button.setImage(UIImage(named: "oh.png"), for: UIControlState.normal)
                    //outcomeLabel.text = "Player 1's turn"
                    
                    isWinner(player: 2)
                }
            }
            
            playerTurn += 1
            if playerTurn > 9 && isWinner(player: 1) < 1 {
                outcomeLabel.text = "Draw"
                for index in 1...9 {
                    let button = self.view.viewWithTag(index) as! UIButton
                    button.isEnabled = false
                }
            }
        }
        
    }
    
    func newGame() {
        playerOneMoves.removeAll()
        playerTwoMoves.removeAll()
        
        outcomeLabel.isHidden = true
        playerTurn = 1
        
        for index in 1...9 {
            let tile = self.view.viewWithTag(index) as! UIButton
            tile.isEnabled = true
            tile.setTitle("", for: UIControlState.normal)
            tile.setImage(nil, for: UIControlState.normal)
        }
    }
    
    
    func isWinner(player: Int) -> Int {
        var winner = 0
        var moveList = Set<Int>()
        
        if player == 1 {
            moveList = playerOneMoves
        } else {
            moveList = playerTwoMoves
        }
        
        for combination in winningCombinations {
            if moveList.contains(combination[0]) && moveList.contains(combination[1]) && moveList.contains(combination[2]) && moveList.count > 2 {
                winner = player
                outcomeLabel.isHidden = false
                outcomeLabel.text = "Player \(player) wins!"
                for index in 1...9 {
                    let tile = self.view.viewWithTag(index) as! UIButton
                    tile.isEnabled = false
                }
            }
        }
        return winner
    }
    
    func playsAI() -> Int {
        var possibleLoses = Array<Array<Int>>()
        var possibleWins = Array<Array<Int>>()
        var spacesLeft = allSpaces.subtracting(playerOneMoves.union(playerTwoMoves))
        
        for combination in winningCombinations {
            
            var count = 0
            
            for play in combination {
                
                if playerOneMoves.contains(play) {
                    count += 1
                }
                if playerTwoMoves.contains(play) {
                    count -= 1
                }
                
                if count == 2 {
                    possibleLoses.append(combination)
                    count = 0
                }
                
                if count == -2 {
                    possibleWins.append(combination)
                    count = 0
                }
            }
        }
        
        if possibleWins.count > 0 {
            
            for combination in possibleWins {
                for spot in combination {
                    if !(playerOneMoves.contains(spot)  || playerTwoMoves.contains(spot)) {
                        return spot
                    }
                }
            }
        }
        
        if possibleLoses.count > 0 {
            
            for combination in possibleWins {
                for spot in combination {
                    if !(playerOneMoves.contains(spot)  || playerTwoMoves.contains(spot)) {
                        possibleMove.append(spot)
                    }
                }
            }
        }
        
        if possibleMove.count > 0 {
            nextMove = possibleMove[Int(arc4random_uniform(UInt32(possibleMove.count)))]
        }else if allSpaces.subtracting(playerOneMoves.union(playerTwoMoves)).count > 0 {
            let randomInt = Int(arc4random_uniform(UInt32(spacesLeft.count)))
            
            nextMove = spacesLeft[spacesLeft.index(spacesLeft.startIndex, offsetBy: randomInt)]
        }
        
        possibleMove.removeAll()
        possibleWins.removeAll()
        possibleLoses.removeAll()
        
        playerTurn += 1
        
        
        return nextMove!
    }
    
    
    
    @IBAction func playAgain(_ sender: Any) {
        newGame()
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }
    
}






class UIStoryboardUnwindSegueFromRightTwo: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        },
                       completion: { finished in
                        src.dismiss(animated: false, completion: nil)
        }
        )
    }
}

