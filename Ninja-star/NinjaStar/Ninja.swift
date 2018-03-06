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

class Ninja{
   var run: Bool
   var sprint: Bool
   var speed: Float
   var shurOrientaion: CGVector
   var playerPos: CGVector
   //init the variables
   init(){
      run = true
      sprint = false
      speed = 5
      shurOrientaion = CGVector(dx: 1.0, dy: 1.0)
      playerPos = CGVector(dx: 1.0, dy: 1.0)
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
   
   //if player taps the right side of the screen, then jump
   func jump(){
      // move up 20
      let jumpUpAction = SKAction.moveBy(x: 0, y: 20, duration: 0.2)
      // move down 20
      let jumpDownAction = SKAction.moveBy(x: 0, y:-20, duration:0.2)
      // sequence of move yup then down
      let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
      
      // make player run sequence
      //player.runAction(jumpSequence)
      
   }
   //if player swipes, then shoot shurikens. pass by reference
   func shoot(recognizer: inout UIGestureRecognizer){
      let point: CGPoint = recognizer.location(in: recognizer.view!)
      if recognizer.state == .began {
         print(NSStringFromCGPoint(point))
      }
      else if recognizer.state == .ended {
         print(NSStringFromCGPoint(point))
         //calculate direction of shuriken
         setOrientation(Vec3: playerPos, endPoint: point)
         // now that you have the orientation, instantiate the shurikens
         
      }
   }
   
   // calculate orientation method
   func setOrientation(Vec3: CGVector, endPoint: CGPoint){
      shurOrientaion = CGVector(dx: endPoint.x - Vec3.dx, dy: endPoint.y - Vec3.dy)
      let denominator = shurOrientaion.dx * shurOrientaion.dy
      shurOrientaion = CGVector(dx: shurOrientaion.dx/denominator, dy: shurOrientaion.dy/denominator)
      
   }
   
   //input handling
   func HandleInput(gesture: UIGestureRecognizer){
      if let swipeGesture = gesture as? UISwipeGestureRecognizer {
         
         
         switch swipeGesture.direction {
         case UISwipeGestureRecognizerDirection.right:
            print("Swiped right")
         case UISwipeGestureRecognizerDirection.down:
            print("Swiped down")
         case UISwipeGestureRecognizerDirection.left:
            print("Swiped left")
         case UISwipeGestureRecognizerDirection.up:
            print("Swiped up")
         default:
            break
         }
      }
   }
}

