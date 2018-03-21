

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView?{
        
            if let scene = MainMenuScene(fileNamed:"MainMenu"){
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
        }
      
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
       
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
