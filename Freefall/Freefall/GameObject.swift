
import Foundation
import SpriteKit



class GameObject: SKSpriteNode {
    
    
    static var zCounter: CGFloat = 1
    
    var deltaTime: TimeInterval = 0.0
    private var lastUpdateTime: TimeInterval?
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        GameObject.zCounter = GameObject.zCounter + 1
        super.init(texture: texture, color: .clear, size: texture.size())
        self.zPosition = GameObject.zCounter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func update(_ currentTime: TimeInterval) {
        guard let lastUpdateTime = lastUpdateTime else {
            self.lastUpdateTime = currentTime
            return
        }
        
      
        deltaTime = currentTime - lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }

   
    func collision(items:[GameObject]) -> [GameObject] {
        
        var collision: Bool
        var colliders: [GameObject] = []
        
        for item in items {
            
            if item !== self {
                collision = self.frame.intersects(item.frame)
                if collision {
                    colliders.append(item)
                }
            }
        }
        
        return colliders
    }
}
