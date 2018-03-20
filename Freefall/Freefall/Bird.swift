
import Foundation
import SpriteKit



enum BirdType: UInt32 {
    case normal = 0
    case slow
    case fast
    
    var speed: CGFloat {
        switch self {
        case .fast:
            return 750.0
        case .normal:
            return 500.0
        case .slow:
            return 250.0
        }
    }
}

class Bird: GameObject {
    
    let type: BirdType
    var vel : CGPoint?
    

    init(type: BirdType) {
        self.type = type
        
        super.init(imageName: "bird")
        
        self.setScale(0.3)
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {

        super.update(currentTime)
        
        guard let direction = vel?.asUnitVector else {
            return
        }
        
        position = position.travel(inDirection: direction, atVelocity: type.speed, for: deltaTime)
    }
    
}
