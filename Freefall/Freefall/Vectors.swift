
import SpriteKit


extension CGPoint {
    
   
    var length: CGFloat {
        return sqrt( x * x + y * y)
    }
    
  
    var asUnitVector: CGPoint {
       return divide(by: length)
    }
    
   
    func divide(by: CGFloat) -> CGPoint {
         return CGPoint(x: self.x / by, y: y / by)
    }
    
  
    func travel(inDirection direction: CGPoint, atVelocity velocity: CGFloat, for time: TimeInterval) -> CGPoint {
        return CGPoint(x: velocity * CGFloat(time) * direction.x + x, y: velocity * CGFloat(time) * direction.y + y)
    }
    
  
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}
