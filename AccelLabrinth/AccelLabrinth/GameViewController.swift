//
//  GameViewController.swift
//  AccelLabrinth
//
//  Created by Predko Brown Marya C. on 3/1/18.
//  Copyright © 2018 Darren/Marya. All rights reserved.

//  Darren Added Accelerator code as it needs an UIViewController

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion

class GameViewController: UIViewController {
    //needs to be made to allow accelorometer
    let motionManager = CMMotionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            //call to start up accelermeter
            motionManager.startAccelerometerUpdates()
            //sets the update intervals to 1 millosecond so it can change fast
            motionManager.accelerometerUpdateInterval = 0.001;
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
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            //prints out the latest information from the accelerometer
            print(accelerometerData)
        }
    }
}
