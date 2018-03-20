                                                                                
import SpriteKit

class MainMenuScene: SKScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Start"{
                
                let scene = GameScene(size: CGSize(width: 480, height: 800))
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: TimeInterval(2)));
            
        }
    }
}
}
