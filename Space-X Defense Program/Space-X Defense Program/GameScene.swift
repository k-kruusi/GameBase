//
//  GameScene.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng on 3/7/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private let background = SKSpriteNode(imageNamed: "background")
    private let player = Player()
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var gameTimer: Timer!                                                               //timer for repeating functions
    var projectileTimer: Timer!                                                         //timer for projectile spawning
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black                                                 //defaulted colored to black for the background
        background.zPosition = Values.bgZPOS                                            //depth of background, -1 makes it go behind other 2D elements
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )           //centering the background images
        background.setScale(Values.bgScale)                                             //Maximizing the pixel resolution for the 1080p
        addChild(background)                                                            //adding the background to the scene
        
        addChild(player)                                                                //adding the spaceship to the scene
        player.position = Values.playerStartPosition                                    //positioning the spaceship to spawn on the centre of the leftmost corner
        player.setScale(Values.playerScale)                                             //scale the spaceship down
        
        
        
        
        
        // Get label node from scene and store it for use later
        /*self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }*/
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.02
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.2) //0.3 default
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 50  //2.5 default
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 3)))  //1 default
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.05),                                //0.5 default i think
                                              SKAction.fadeOut(withDuration: 0.2),                             //0.5 default
                                              SKAction.removeFromParent()]))
        }
        
        
        //Spawning the projectiles
        /*run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addProjectiles),
                SKAction.wait(forDuration: 1.0)
                ])
        ))*/
    }
    
    //Mouse Interactions (On Touch)
    func touchDown(atPoint pos : CGPoint) {
        
        
        //addChild(projectiles)
        //projectiles.position.x += 220
        //projectiles.position.y = pos.y
        
    }
    
    //This function tracks the movement of the touch input for the spaceship
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position.y = pos.y
            n.strokeColor = SKColor.yellow
            self.addChild(n)
  
            //limiting the Y of the thrusters to match the ships
            if(n.position.y > 1420){n.position.y = 1420}
            if(n.position.y < 120){n.position.y = 120}
        }
        
        //moving the ship to match the touch movement
        player.position.y = pos.y
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Thruster) , userInfo: nil, repeats: true)
        
        projectileTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addProjectiles) , userInfo: nil, repeats: true)
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        gameTimer.invalidate()
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    @objc func Thruster()
    {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position.y = player.position.y
            n.strokeColor = SKColor.yellow
            self.addChild(n)
        }
    }
    
    @objc func addProjectiles() {
        
        // Create projectiles
        let Projectiles = Projectile()
        
        // Determine where to spawn the monster along the Y axis
        Projectiles.position = CGPoint(x: 220, y: player.position.y)
        
        // Add the projectiles to the scene
        addChild(Projectiles)
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: 2500, y: player.position.y), duration: TimeInterval(Values.actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        Projectiles.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //limiting the spaceship from going too high and too low on the screen
        if(player.position.y < 120){player.position.y = 120}
        if(player.position.y > 1420){player.position.y = 1420}
        
    }
    
   
}
