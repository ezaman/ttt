//
//  BeginningViewController.swift
//  ticTacToe
//
//  Created by Ehsan Zaman on 4/24/17.
//  Copyright © 2017 Ehsan Zaman. All rights reserved.
//

import UIKit

class BeginningViewController: UIViewController {

    @IBOutlet weak var singlePlayer: UIButton!
    @IBOutlet weak var multiPlayer: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singlePlayer.layer.cornerRadius = 62.5
        multiPlayer.layer.cornerRadius = 62.5
    }


}
