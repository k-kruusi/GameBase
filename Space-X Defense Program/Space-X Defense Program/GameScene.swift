//
//  GameScene.swift
//  Space-X Defense Program
//
//  Created by Su Haifeng and Favero Miguel on 3/7/18.
//  Copyright © 2018 Su Haifeng. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private let background = SKSpriteNode(imageNamed: "background")
    private let player = Player()
    private var projectileList: [Projectile] = []
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var gameTimer: Timer!                                                               //timer for repeating functions
    var projectileTimer: Timer!                                                         //timer for projectile spawning
    var enemyProjTimer: Timer!
    var tempPlane: EnemyPlane!
    
    private var spawnManager: EnemySpawnManager?
    private var planes: [EnemyPlane] = []
    private var enemyProjList: [Projectile] = []
    
    override func didMove(to view: SKView) {
       // super.didMove(to: view)
              
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
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.2) //0.3 default
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 50  //2.5 default
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 3)))  //1 default
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.05),                                //0.5 default i think
                                              SKAction.fadeOut(withDuration: 0.2),                             //0.5 default
                                              SKAction.removeFromParent()]))
        }
      
        spawnManager = EnemySpawnManager(givenSpawnArea: CGRect(x: self.size.width, y: self.size.height / 6, width: 50, height: self.size.height / 2), min: 0.5, max: 1)
        spawnManager?.scene = self
    }
  
    //Mouse Interactions (On Touch)
    func touchDown(atPoint pos : CGPoint) {
        
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
        projectileTimer.invalidate()
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    @objc func Thruster()
    {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position.y = player.position.y
//            n.strokeColor = SKColor.yellow
//            self.addChild(n)
//        }
    }
    
    @objc func addProjectiles() {
        
        // Create projectiles
        let Projectiles = Projectile(type: ProjectileType.player)
        
        // Determine where to spawn the monster along the Y axis
        Projectiles.position = CGPoint(x: 220, y: player.position.y)
        Projectiles.vel = CGPoint(x: 1, y: 0)
        
        // Add the projectiles to the scene
        addChild(Projectiles)
        
        // Create the actions
        //let actionMove = SKAction.move(to: CGPoint(x: 2500, y: player.position.y), duration: TimeInterval(Values.actualDuration))
        //let actionMoveDone = SKAction.removeFromParent()
        //Projectiles.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        projectileList.append(Projectiles)
    }
    
    @objc func addEnemyProjectiles() {
        
        // Create projectiles
        let projectiles = Projectile(type: ProjectileType.enemy)
        
        // Determine where to spawn the monster along the Y axis
        projectiles.position = CGPoint(x: tempPlane.position.x, y: tempPlane.position.y)
        projectiles.vel = CGPoint(x: -1, y: 0)
        
        // Add the projectiles to the scene
        addChild(projectiles)
        
        enemyProjList.append(projectiles)
    }
    
    deinit {
        planes = []
        projectileList = []
        enemyProjList = []
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        //super.update(currentTime)
      
        //limiting the spaceship from going too high and too low on the screen
        if(player.position.y < 120){player.position.y = 120}
        if(player.position.y > 1420){player.position.y = 1420}
        
        for projectile in projectileList
        {
            projectile.update(currentTime)
            
            if projectile.position.x > 2100
            {
                projectile.cleanUp()
                projectileList.remove(at: projectileList.index(of: projectile)!)
            }
        }
        
        for projectile in enemyProjList
        {
            projectile.update(currentTime)
            
            if projectile.position.x < 0
            {
                projectile.cleanUp()
                enemyProjList.remove(at: enemyProjList.index(of: projectile)!)
            }
            
            let playerPlane = projectile.collision(items: [player]).first
            
            if let _ = playerPlane
            {
                player.cleanUp()
                
                projectile.cleanUp()
                enemyProjList.remove(at: enemyProjList.index(of: projectile)!)
            }
        }
        
        for plane in planes
        {
            plane.update(currentTime)
            
            if plane.type == EnemyPlaneType.smarter && plane.canShoot == true
            {
                plane.canShoot = false;
                enemyProjTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addEnemyProjectiles) , userInfo: nil, repeats: false)
                tempPlane = plane
            }
            
            for projectile in projectileList
            {
                let proj = plane.collision(items: [projectile]).first
                
                if let _ = proj
                {
                    plane.cleanUp()
                    projectile.cleanUp()
                    
                    planes.remove(at: planes.index(of: plane)!)
                    projectileList.remove(at: projectileList.index(of: projectile)!)
                }
            }
        }
        
        if(planes.count < 5)
        {
            guard let plane = spawnManager?.update(time: currentTime) else {
                return
            }
        
            planes.append(plane)
        }
        
    }
}
