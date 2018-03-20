
import Foundation
import SpriteKit

class SpawnManager{
    
    weak var scene : SKScene?

    
    let spawnArea : CGRect
    let randMin : Double
    let randMax : Double

   
    private var startTime : TimeInterval?
    private var nextSpawnTime : TimeInterval?
    
    private let birdFactory : BirdFactory
    private let powerFactory : PowerFactory

    init(givenSpawnArea : CGRect, min : TimeInterval, max : TimeInterval) {
        randMin = min
        randMax = max
        birdFactory = BirdFactory()
        powerFactory = PowerFactory()
        spawnArea = givenSpawnArea
   
        nextSpawnTime = random(min: randMin, max: randMax)
    }
    
    
    func update(time: TimeInterval) -> Bird? {
        guard let scene = scene, let startTime = startTime, let nextSpawnTime = nextSpawnTime else {
            guard let _ = self.scene else {
                return nil
            }
           
            self.startTime = time;
            return nil;
        }
        
   
        let deltaTime = time - startTime;
        
        guard deltaTime > nextSpawnTime else {
            
            return nil
        }
        
        
        self.nextSpawnTime = nextSpawnTime + random(min: randMin, max: randMax);
        
      
        let myBird = birdFactory.makeBird(birdType: nil);
        let myPower = powerFactory.makePower(powerType: nil);
        
       
        myBird.vel = CGPoint(x: 0,y: 1)
        myPower.vel = CGPoint(x: 0, y: 1)
        
   
        scene.addChild(myBird);
        scene.addChild(myPower)

       
        myBird.position = generateSpawnPosition()
        myPower.position = generateSpawnPosition()
        
       
        return myBird
    }


    private func generateSpawnPosition() -> CGPoint {
        return CGPoint(x: random(min: Double(spawnArea.minX), max: Double(spawnArea.maxX)),
                       y: random(min: Double(spawnArea.minY), max: Double(spawnArea.maxY)))
    }
    
  
    private func random(min: TimeInterval, max: TimeInterval) -> Double {
        return Double(CGFloat.random(min: CGFloat(min), max: CGFloat(max)))
    }
}
