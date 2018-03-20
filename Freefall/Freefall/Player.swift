
import Foundation
import SpriteKit



class Player: GameObject {

    
    private static let playerZPositionOffset: CGFloat = 1000
    
    
    var target: CGPoint?
    
    private let velocity: CGFloat = 325
    
    
    init() {
        super.init(imageName: "betty")
        self.zPosition = self.zPosition + Player.playerZPositionOffset
        self.setScale(0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
      
        super.update(currentTime)
        
      
        guard let target = target else {
            return
        }
        
       
        let dVector = target - position

         guard dVector.length > 5 else {
         
            self.target = nil
            return
        }
        
      
        self.position = position.travel(inDirection: dVector.asUnitVector, atVelocity: velocity, for: deltaTime)
        self.position.y = 730
    }
}
