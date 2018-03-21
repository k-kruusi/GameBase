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
    
    override func didMove(to view: SKView) {
        
        //Background Music
        let backgroundMusic = SKAudioNode(fileNamed: "Starship.wav")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        backgroundColor = SKColor.black                                                 //defaulted colored to black for the background
        background.zPosition = Values.bgZPOS                                            //depth of background, -1 makes it go behind other 2D elements
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )           //centering the background images
        background.setScale(Values.bgScale)                                             //Maximizing the pixel resolution for the 1080p
        addChild(background)                                                            //adding the background to the scene
        
        addChild(player)                                                                //adding the spaceship to the scene
        player.position = Values.playerStartPosition                                    //positioning the spaceship to spawn on the centre of the leftmost corner
        player.setScale(Values.playerScale)                                             //scale the spaceship down
        
        
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.02
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.2)     //0.3 default
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 50                                                                           //2.5 default
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 3)))   //1 default
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.05),                                 //0.5 default i think
                                              SKAction.fadeOut(withDuration: 0.2),                              //0.5 default
                                              SKAction.removeFromParent()]))
        }
        
        
        //continuously spawning projectiles from the player
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addProjectiles),
                SKAction.wait(forDuration: 1.0)
                ])
        ))
        
        
        
        
    }
    
    //Mouse Interactions (On Touch)
    func touchDown(atPoint pos : CGPoint) {
        
        
        
        
    }
    
    //This function tracks the movement of the touch input for the spaceship
    func touchMoved(toPoint pos : CGPoint) {
        
        //moving the ship to match the touch movement
        player.position.y = pos.y
        
        
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
        n.position.y = pos.y
        n.strokeColor = SKColor.yellow
        self.addChild(n)
  
        //limiting the Y of the thrusters to match the ships
        if(n.position.y > Values.maxY){n.position.y = Values.maxY}
        if(n.position.y < Values.minY){n.position.y = Values.minY}
            
        }
        
    }
    
    //Mouse up interaction
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    //Mouse held down interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Start of thruster function when mouse is being held down
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Thruster) , userInfo: nil, repeats: true)
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    //Mouse moved interaction (multiple input)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    
    //Mouse released (end of touchesBegan) interaction
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Sound effect for rockets
        run(SKAction.playSoundFileNamed("fire.wav", waitForCompletion: false))
        
        //Stop thruster function on mouse released
        gameTimer.invalidate()
        
        //setting up the rockets on touch end
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        
        let randX : CGFloat = CGFloat.random(min: 0, max: self.size.width)
        
        
        //Set up initial location of rockets
        let rockets = Rocket(newPos: randX)
        rockets.setScale(Values.rocketScale)
        
        //Determine offset of location to projectile
        let offset = touchLocation - rockets.position
        let angle : CGFloat = CGPoint.facingAngle(offset)
        rockets.zRotation = angle
        
        
        
        
        //adding the rockets to the scene
        addChild(rockets)
        
        //Get the direction of where to shoot
        let direction = offset.normalized()
        
        
        //Make it shoot far enough to be guaranteed off screen
        let shootAmount = direction * 2000
        
        //Add the shoot amount to the current position
        let realDest = shootAmount + rockets.position
        
        //Create the actions
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        rockets.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    //Rocket boosters function
    @objc func Thruster()
    {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position.y = player.position.y
            n.strokeColor = SKColor.yellow
            self.addChild(n)
        }
    }
    
    
    //Projectiles spawning function
    @objc func addProjectiles() {
        
        // Create projectiles
        let Projectiles = Projectile()
        
        // Determine where to spawn the monster along the Y axis
        Projectiles.position = CGPoint(x: 220, y: player.position.y)
        
        Projectiles.setScale(Values.projectileScale)
        
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
        if(player.position.y < Values.minY){player.position.y = Values.minY}
        if(player.position.y > Values.maxY){player.position.y = Values.maxY}
        
        
        
        
    }
    
   
}
