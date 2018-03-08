//
//  GameScene.swift
//  BlockFrenzy
//
//  Created by McLoughlin David J. on 3/8/18.
//  Copyright © 2018 McLoughlin David J. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    let BallCatName = "ball"
    let paddleCatName = "paddle"
    let BlockCatName = "block"
    
    
    var BackgroundMusic = AVAudioPlayer()
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        guard let bgMusic = Bundle.main.url(forResource: "Dark_Knight_Dummo", withExtension: "mp3") else {
            return
        }
        
        do {
            try BackgroundMusic = AVAudioPlayer(contentsOf: bgMusic)
            BackgroundMusic.numberOfLoops = -1;
            BackgroundMusic.prepareToPlay()
            BackgroundMusic.play()
            
        } catch{
            print(error)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
