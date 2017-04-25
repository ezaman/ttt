//
//  ViewController.swift
//  ticTacToe
//
//  Created by Ehsan Zaman on 4/22/17.
//  Copyright © 2017 Ehsan Zaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var activePlayer = 1
    var gamestate = [0,0,0,0,0,0,0,0,0]
    var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7],[2,5,8],[2,4,6],[6,4,2],[0,4,8]]
    var gameIsActive = true
    
    @IBOutlet weak var outcomeLabel: UILabel!
    
    @IBAction func action(_ sender: UIButton) {
        
        if gamestate[sender.tag - 1] == 0 && gameIsActive == true{
            gamestate[sender.tag - 1] = activePlayer
            if (activePlayer == 1) {
                sender.setImage(UIImage(named: "ex.png"), for: UIControlState())
                activePlayer = 2
            }else {
                sender.setImage(UIImage(named: "oh.png"), for: UIControlState())
                activePlayer = 1
            }
        }
        
        
        for combination in winningCombinations {
            if gamestate[combination[0]] != 0 && gamestate[combination[0]] == gamestate[combination[1]] && gamestate[combination[1]] == gamestate[combination[2]] {
                
                print(gamestate[combination[0]])
                gameIsActive = false
                
                if gamestate[combination[0]] == 1 {
                    outcomeLabel.text = "Player 1 wins!"
                }else {
                    outcomeLabel.text = "Player 2 wins!"
                }
                
                playAgainButton.isHidden = false
                outcomeLabel.isHidden = false
            }
        }
        
        var count = 1
        
        if gameIsActive == true {
            for i in gamestate {
                count = i * count
            }
            if count != 0 {
                outcomeLabel.text = "Draw"
                outcomeLabel.isHidden = false
                playAgainButton.isHidden = false
            }
        }
    }
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: Any) {
        gamestate = [0,0,0,0,0,0,0,0,0]
        gameIsActive = true
        activePlayer = 1
        playAgainButton.isHidden = false
        outcomeLabel.isHidden = true
        
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outcomeLabel.isHidden = true
        playAgainButton.isHidden = false
     
    }

}



// Custom segue classes
class SegueFromRight: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
        }
        )
    }
}


class UIStoryboardUnwindSegueFromRight: UIStoryboardSegue {
    
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

