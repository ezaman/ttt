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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
