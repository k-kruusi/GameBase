

import Foundation



class BirdFactory {
    
    func makeBird(birdType: BirdType?) -> Bird {
        
        guard let birdType = birdType else {
            
            return randomBird()
        }
        
        return Bird(type: birdType)
    }
    
   
    private func randomBird() -> Bird {
        let rand: UInt32 = arc4random() % 3
        let birdType = BirdType(rawValue: rand)
       
        return Bird(type: birdType!)
    }
}
