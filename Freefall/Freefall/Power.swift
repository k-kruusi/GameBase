
import Foundation
import SpriteKit

enum PowerType: UInt32 {
    case Nuke
    case Slow
    case Speed
    
    var powerClass: CGFloat {
        switch self {
        case .Speed:
            return 500.0
        case .Nuke:
            return 500.0
        case .Slow:
            return 500.0
        }
    }
}

class Power: GameObject {
    
    let type: PowerType
    var vel : CGPoint?
    
    
    init(type: PowerType) {
        self.type = .Slow
        
        super.init(imageName: "")
        
        self.setScale(0.15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        super.update(currentTime)
        
        guard let direction = vel?.asUnitVector else {
            return
        }
        
        position = position.travel(inDirection: direction, atVelocity: type.powerClass, for: deltaTime)
    }
    
}
