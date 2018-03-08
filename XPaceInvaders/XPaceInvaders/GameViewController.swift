//
//  GameViewController.swift
//  XPaceInvaders
//
//  Created by Fonseca Barbalho Talis on 3/1/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
           // if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
            //    scene.scaleMode = .aspectFill
                
                // Present the scene
            //    view.presentScene(scene)
            //}

            
            // Load the SKScene from 'GameScene.sks'
            let scene = GridGameScene(size: view.frame.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func startGame()
    {
        
    }
}
