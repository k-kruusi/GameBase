//
//  UserScoreScene.swift
//  NinjaStar
//
//  Created by adid nissan on 2018-04-24.
//  Copyright © 2018 Nissan Adid. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import UIKit
import FirebaseDatabase

class UserScoreScene: SKScene {
    
    //the user score
    var myScore: Float = 0.0
    //The user Score Label
    var myScoreLabel: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    //The user name Score
    // Buttons
    var UploadScore = SKLabelNode()
    //Reference to the database
    var ref: DatabaseReference!
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
        
        //Setup the score label
        myScoreLabel.text = String(self.myScore)
        myScoreLabel.zPosition = 10
        myScoreLabel.fontSize = 30
        myScoreLabel.fontColor = SKColor.white
        myScoreLabel.position = CGPoint(x: frame.midX, y: (frame.midY))
        addChild(myScoreLabel)
        
        //create the play game label
        UploadScore = CreateLabel(position: CGPoint(x: 0, y: -100), name: "Upload Score", fontsize: 65, color: UIColor.white)
        addChild(UploadScore)
        
        
        //set reference to the database
        ref = Database.database().reference().child("leaderboard").child("scoreList").child("name")
        
    }
    
    //Update
    override func update(_ currentTime: TimeInterval) {
        //display score
        myScoreLabel.text = "\(myScore)"
    }
    
    //Create label function
    func CreateLabel(position: CGPoint, name: String, fontsize: CGFloat, color: UIColor) ->SKLabelNode{
        let Label = SKLabelNode(text: name)
        Label.position = position
        Label.fontSize = fontsize
        Label.color = color
        return Label
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //when the user clicks on Upoad Score, Upload the score to the server
        for touch in touches {
            let location = touch.location(in: self)
            if UploadScore.contains(location){
                //Set the player Score
                ref.child("name").updateChildValues(["name": "Player"])
                ref.child("score").updateChildValues(["score": myScore])
                { (err, resp) in
                    guard err == nil else {
                        print("Posting failed : ")
                        print(err)
                        
                        return
                    }
                    print("No errors while posting, :")
                    print(resp)
                }
                //go back to the main menu
                let gameScene = GameScene(fileNamed: "GameScene")!
                gameScene.scaleMode = .aspectFill
                let myTransition = SKTransition.moveIn(with: .up, duration: 1.0)
                self.view?.presentScene(gameScene, transition: myTransition)
            }
        }
    }
}
