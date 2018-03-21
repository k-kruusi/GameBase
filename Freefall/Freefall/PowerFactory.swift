

import Foundation


class PowerFactory{
    
    func makePower(powerType: PowerType?) -> Power {
        
        guard let powerType = powerType else {
            
            return randomPower()
        }
        
        return Power(type: powerType)
    }
    
    
    private func randomPower() -> Power {
        let rand: UInt32 = arc4random() % 3
        let powerType = PowerType(rawValue: rand)
        
        return Power(type: powerType!)
    }
}
