//
//  MainMenuViewController.swift
//  XPaceInvaders
//
//  Created by Fonseca Barbalho Talis on 3/8/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MainMenuViewController : UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let theGameScene : GameScene = GameScene(size: CGSize(width: 3000, height: 2000))
        view = SKView(frame: view.frame)
        let skView = self.view as! SKView
        
        skView.presentScene(theGameScene)
    }
}
