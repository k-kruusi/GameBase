
import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
   
    private var spawnManager: SpawnManager?
    private var birds: [Bird] = []
    
    private let player = Player()
    
    
    func createBackground() {
        let backgroundTexture = SKTexture(imageNamed: "Sky")
        
        for i in 0 ... 1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -30
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 800)
            addChild(background)
            background.zRotation = CGFloat(Double.pi/2)*3;
            background.xScale = 1.5
            let moveDown = SKAction.moveBy(x: 0, y: backgroundTexture.size().height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: -backgroundTexture.size().height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            
            background.run(moveForever)
        }
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        spawnManager = SpawnManager(givenSpawnArea: CGRect(x:0 , y: 0, width: 460, height: 0), min: 1, max: 1);
        spawnManager?.scene = self
        backgroundColor = SKColor.black
    
        addChild(player)
        player.zPosition = 1
        player.position = CGPoint(x: 240, y: 730)
        
        createBackground()
    }
    
    deinit {
        birds = []
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
       
        player.update(currentTime)
    
        var toBeDeleted : [Int] = []
        
        for bird in birds {
            
            if bird.position.y > 810{
                
                bird.removeFromParent()
                
        
                toBeDeleted.append(birds.index(of: bird)!)
            }
            
          
            bird.update(currentTime)
            
          
            let playerCollision = bird.collision(items: [player]).first
            
           
            if let _ = playerCollision {
                print("Collision")
               
                bird.removeFromParent()
                
                
                toBeDeleted.append(birds.index(of: bird)!)
                
                if let scene = GameOverScene(fileNamed:"GameOver"){
                    scene.scaleMode = .aspectFill
                    view!.presentScene(scene)
                }
            }
        }
        
        deleteBirds(toBeDeleted)

       
        guard let bird = spawnManager?.update(time: currentTime) else {
            return
        }
        birds.append(bird)
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        player.target = touch.location(in: self)
    }
    
   
    private func deleteBirds(_ birdIndexes: [Int]) {
        
       
        let reversedIndexes = birdIndexes.reversed()
        
        for index in reversedIndexes {
            birds.remove(at: index)
        }
    }
}
