//

//  Ninja.swift

//  NinjaStar

//

//  Created by adid nissan on 2018-03-03.

//  Copyright © 2018 Nissan Adid. All rights reserved.

//



import Foundation

import UIKit

import SpriteKit



final class Ninja: SKSpriteNode {
    
    //Singleton Pattern; works only if all inits are private
    static let ninjaInstance = Ninja()
    
   //the ninja animations
   var NinjaFrames: [SKTexture]?
   
   // bool that keeps track of weather the player jumped
    var isJumping = false
    
    //Linked list of shurikens
    var ShurikenList = LinkedList<Shuriken>()
   
    //the latest shuriken
    var latestShuriken : Shuriken?
    
    //Max Screen Size
    var maxScreenWidth = UIScreen.main.bounds.maxX
    
    //Min Screen Size
    var maxScreenHeight = UIScreen.main.bounds.maxY
    
   //animation enumerator
   enum ninjaAnimation {
      case IDLE
      case RUN
      case ATTACK
      case THROW
      case JUMP
      case JUMPATTACK
      case JUMPTHROW
   }
   //animation indexes
   var indexStart: Int = 0
   var indexEnd: Int = 9
   
   var run: Bool
   var sprint: Bool
   
   //var speed: Float
   
   var shurOrientaion: CGVector
   
   var playerPos: CGVector
   
   //store time interval and last update time so that we can update the ninja object
   var deltaTime: TimeInterval = 0.0
   private var lastUpdateTime: TimeInterval?
   
   
   //default init override
   private init() {
      let texture = SKTexture(imageNamed: "Idle__000")
      //GameObject.zCounter = GameObject.zCounter + 1
      run = true
      sprint = false
      shurOrientaion = CGVector(dx: 1.0, dy: 1.0)
      playerPos = CGVector(dx: 1.0, dy: 1.0)
      let boxSize: CGSize = CGSize(width: texture.size().width/5, height: texture.size().height/5)
      super.init(texture: texture, color: .clear, size: boxSize)
      //Set Up the Physics for the Player.
      self.physicsBody = SKPhysicsBody(rectangleOf: boxSize)
      self.physicsBody?.affectedByGravity = true
      if let physics = physicsBody {
         physics.mass = 1
         physics.affectedByGravity = true
         physics.allowsRotation = false
         physics.isDynamic = true
         physics.usesPreciseCollisionDetection = true
        
      }
      
   }
   
   //init the variables
   private override init(texture: SKTexture!, color: SKColor!, size: CGSize) {
      
      sprint = false
      run = true
      shurOrientaion = CGVector(dx: 1.0, dy: 1.0)
      playerPos = CGVector(dx: 1.0, dy: 1.0)
      
      super.init(texture: texture, color: color, size: size)
      
      //set a name to thePlayer
      name = "Ninja"
      speed = 5
      
      
   }
   
   
   //Update
   func update(_ currentTime: TimeInterval) {
      guard let lastUpdateTime = lastUpdateTime else {
         self.lastUpdateTime = currentTime
         return
      }
      
      // calculating delta time
      deltaTime = currentTime - lastUpdateTime
      
      self.lastUpdateTime = currentTime
   }
   
   //run animation
   func SetNinjaAnimations(playAnim: ninjaAnimation){
      let text: String?
      switch playAnim{
      case .ATTACK:
         text = "Attack__00"
         indexStart = 0
         indexEnd = 9
         break
      case .IDLE:
         text = "Idle__00"
         indexStart = 0
         indexEnd = 9
         break
      case .JUMP:
         text = "Jump__00"
         indexStart = 0
         indexEnd = 9
         break
      case .JUMPATTACK:
         text = "Jump_Attack__00"
         indexStart = 0
         indexEnd = 9
         break
      case .JUMPTHROW:
         text = "Jump_Throw__00"
         indexStart = 0
         indexEnd = 9
         break
      case .RUN:
         text = "Run__00"
         indexStart = 0
         indexEnd = 9
         break
      case .THROW:
         text = "Throw__00"
         indexStart = 0
         indexEnd = 9
         break
      }
      //Set up the ninja sprite animations
      var frames:[SKTexture] = []
      
      let ninjaAtlas = SKTextureAtlas(named: "Ninja")
      
      for index in indexStart ... indexEnd {
        let textureName = text! + (String(index))
         let texture = ninjaAtlas.textureNamed(textureName)
         frames.append(texture)
      }
      
      self.NinjaFrames = frames
      
      //default frame
      texture = self.NinjaFrames![0]
      //set sprite size
    var width = 129
    if(playAnim == .IDLE){
        width = 80
    }
      size = CGSize(width: width, height: 140)
      let yPosition = -55
      let xPosition = 0
      
      if(position != nil){
      position = CGPoint(x: xPosition, y: yPosition)
      }
      
    
   }
    
    func animateNinja(){
        run(SKAction.repeatForever(SKAction.animate(with: self.NinjaFrames!, timePerFrame: 0.1, resize: false, restore: true)), withKey: "RunAnimation")
    }
   
   private init(skspritenode: SKSpriteNode) {
      sprint = false
      
      run = true
      
      
      shurOrientaion = CGVector(dx: 1.0, dy: 1.0)
      
      playerPos = CGVector(dx: 1.0, dy: 1.0)
      
      super.init(texture: skspritenode.texture, color: skspritenode.color, size: skspritenode.size)
      //set a name to thePlayer
      name = "Ninja"
      
      speed = 5
      
      //set the physics body to false
      physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: skspritenode.size.width,
                                                            height: skspritenode.size.height))
      physicsBody?.isDynamic = false
      
    
   }
   
   
   convenience init(color: SKColor, length: CGFloat = 10) {
      let size = CGSize(width: 1, height: 1)
      self.init(texture:nil, color: color, size: size)
      //self.length = length
   }
   
   required init?(coder aDecoder: NSCoder) {
      sprint = false
      
      run = true
      
      
      shurOrientaion = CGVector(dx: 1.0, dy: 1.0)
      
      playerPos = CGVector(dx: 1.0, dy: 1.0)
      //
      super.init(coder: aDecoder)
   }
  //if player holds the right side of the screen, then sprint, otherwise, go back to running
   
   func move(){
      
      if(run){
         
         speed = 5
         
      }
         
      else{
         
         speed = 10
         
      }
      
   }
   
   //animate running
   func update(){
    if(ShurikenList.size > 0){
        var i = 0
        while (i < ShurikenList.size) {
            ShurikenList.nodeAt(index: i)?.value.UpdateShuriken()
            //remove the shuriken once it is outside the screen
            if(!(((ShurikenList.nodeAt(index: i)?.value.position.x)! < maxScreenWidth) && (ShurikenList.nodeAt(index: i)?.value.position.x)! >
                (0.0 - maxScreenWidth))){
                ShurikenList.nodeAt(index: i)?.value.texture = nil
                ShurikenList.remove(node: ShurikenList.nodeAt(index: i)!)
            }
            else if(!(((ShurikenList.nodeAt(index: i)?.value.position.y)! < maxScreenHeight) && (ShurikenList.nodeAt(index: i)?.value.position.y)! >
                (0.0 - maxScreenHeight))){
                ShurikenList.nodeAt(index: i)?.value.texture = nil
                ShurikenList.remove(node: ShurikenList.nodeAt(index: i)!)
            }
            i += 1
        }
    }
   }
   
   //if player taps the right side of the screen, then jump
   
   static func Jump(){
    if !ninjaInstance.isJumping {
      let force = CGVector(dx: 0, dy: 20000)
      ninjaInstance.physicsBody?.applyForce(force)
      ninjaInstance.isJumping = true
    }
      
      
   }
   
   //if player swipes, then shoot shurikens. pass by reference
   
   func shoot(shurknOrgn: CGPoint, shurknDir: CGPoint){
    latestShuriken = Shuriken(playerPos: position)
    latestShuriken?.shoot(shurikenOrgn: shurknOrgn, shurikenDir: shurknDir)
    //add shuriken to my shurikenlist
    ShurikenList.append(value: latestShuriken!)
    
   }
   
   
   
   // calculate orientation method
   
   func setOrientation(Vec3: CGVector, endPoint: CGPoint){
      
      shurOrientaion = CGVector(dx: endPoint.x - Vec3.dx, dy: endPoint.y - Vec3.dy)
      
      let denominator = shurOrientaion.dx * shurOrientaion.dy
      
      shurOrientaion = CGVector(dx: shurOrientaion.dx/denominator, dy: shurOrientaion.dy/denominator)
      
      
      
   }
   
   
   
   //input handling
   
//   func HandleInput(gesture: UIGestureRecognizer){
//      
//      if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//         
//         
//         
//         
//         
//         switch swipeGesture.direction {
//            
//         case UISwipeGestureRecognizerDirection.right:
//            
//            print("Swiped right")
//            
//         case UISwipeGestureRecognizerDirection.down:
//            
//            print("Swiped down")
//            
//         case UISwipeGestureRecognizerDirection.left:
//            
//            print("Swiped left")
//            
//         case UISwipeGestureRecognizerDirection.up:
//            
//            print("Swiped up")
//            
//         default:
//            
//            break
//            
//         }
//         
//      }
//      
//   }
   
}
