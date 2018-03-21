//
//  CameraComponent.swift
//  WarriorOfLeporia
//
//  Created by Nijastan Kirupa on 3/20/18.
//  Copyright © 2018 Kirupa Nijastan. All rights reserved.
//

import SpriteKit
import GameplayKit

class CameraComponent : GKComponent {
    let camera: SKCameraNode
    let view: SKView
    let node: SKSpriteNode
    let background: SKNode
    
    init(camera: SKCameraNode, view: SKView, node: SKSpriteNode, background: SKNode) {
        self.camera = camera
        self.view = view
        self.node = node
        self.background = background
        super.init()
        
        initCamera()
    }
    
    func initCamera() {
        
        let noRange = SKRange(constantValue: 0)
        let pconstraint = SKConstraint.distance(noRange, to: node)
        
        let xIn = min(view.bounds.width/2 * camera.xScale, (background.frame.width)/2)
        let yIn = min(view.bounds.height/2 * camera.yScale, (background.frame.height)/2)
        
        let constraintRect = background.frame.insetBy(dx: xIn, dy: yIn)
        let xRange = SKRange(lowerLimit: (constraintRect.minX), upperLimit: (constraintRect.maxX))
        let yRange = SKRange(lowerLimit: (constraintRect.minY), upperLimit: (constraintRect.maxY))
        let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        camera.constraints = [pconstraint, edgeConstraint]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
