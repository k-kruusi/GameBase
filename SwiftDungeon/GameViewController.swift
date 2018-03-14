//
//  GameViewController.swift
//  SwiftDungeon
//
//  Created by Toro Juan D. on 2/28/18.
//  Copyright © 2018 Toro Juan D. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    let scene = GameScene(size: CGSize(width: 2048, height: 1536))
    override func viewDidLoad() {
        super.viewDidLoad()
        //let scene = GameScene(size: CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func attackAction(_ sender: Any) {
        scene.gameManager?.player.attack()
        
       
    }
}
