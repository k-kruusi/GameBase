//
//  Level.swift
//  XPaceInvaders
//
//  Created by Mazza Matthew J. on 3/8/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import GameplayKit

class Level {
    let myGraph = GKGraph()
    
    var arr: [[GraphNode?]] = []
    var startNode : GraphNode?
    var endNode : GraphNode?
    
    var scaleX : CGFloat = 0.0
    var scaleY : CGFloat = 0.0
    
    var resultPath: [GKGraphNode] = []
    
    var actions : [SKAction] = []
    
    func getActionsPath() -> [SKAction]
    {
        return actions;
    }

    //put stuff here
    //this is for the grid
    init(levelName: String)
    {
        if let path = Bundle.main.path(forResource: levelName, ofType: "txt")
        {
            
            var readStringProject = ""
            do {
                readStringProject = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                var result: [String] = []
                readStringProject.enumerateLines {
                    (line, _) -> () in
                    result.append(line)
                }
                
                // parsing the levevel name
                // let levelName = result[0]
                
                // parsing the number of rows and colums
                let rowsColsArray = result[1].split(separator: " ")
                let rows : Int = Int(rowsColsArray[0])!
                let cols : Int = Int(rowsColsArray[1])!
                scaleX = UIScreen.main.bounds.width/CGFloat(rows)
                scaleY = UIScreen.main.bounds.height/CGFloat(cols)
                print(scaleX)
                print(scaleY)
                
                // getting the information to create each node
                for i in 2...(result.count-1)
                {
                    // each row in the level matrix
                    let cellsArray = result[i].split(separator: " ")
                    arr.append([]) // adding a new row
                    
                    for j in 0...(cellsArray.count-1)
                    {
                        
                        let currentValue: Int = Int(cellsArray[j])!
                        
                        if(currentValue > 0)
                        {
                            let currentNode = GraphNode(row: i-1,col: j)
                            arr[i - 2].append(currentNode)
                            myGraph.add([currentNode])
                            if currentValue == 100
                            {
                                startNode = currentNode
                            }
                            if currentValue == 101
                            {
                                endNode = currentNode
                            }
                        } else
                        {
                            arr[i - 2].append(nil)
                        }
                    }
                }
                
                // adding connections between nodes
                let rowLimit = (arr.count - 1)
                for i in 0...rowLimit
                {
                    let colLimit = arr[i].count - 1
                    for j in 0...colLimit
                    {
                        // inside the square
                        if i > 0 && i < (rowLimit) && j > 0 && j < (colLimit)
                        {
                            // up
                            if arr[i-1][j] != nil
                            {
                                arr[i][j]?.addConnections(to: [arr[i-1][j]!], bidirectional: true)
                            }
                            // left
                            if arr[i][j-1] != nil
                            {
                                arr[i][j]?.addConnections(to: [arr[i][j-1]!], bidirectional: true)
                            }
                            // right
                            if arr[i][j+1] != nil
                            {
                                arr[i][j]?.addConnections(to: [arr[i][j+1]!], bidirectional: true)
                            }
                            // down
                            if arr[i + 1][j] != nil
                            {
                                arr[i][j]?.addConnections(to: [arr[i+1][j]!], bidirectional: true)
                            }
                        } else
                        {
                            if i == 0
                            {
                                if j == 0
                                {
                                    // right
                                    if arr[i][j+1] != nil
                                    {
                                        arr[i][j]?.addConnections(to: [arr[i][j+1]!], bidirectional: true)
                                    }
                                }
                                else
                                {
                                    // left
                                    if arr[i][j-1] != nil
                                    {
                                        arr[i][j]?.addConnections(to: [arr[i][j-1]!], bidirectional: true)
                                    }
                                }
                                
                                // down
                                if arr[i + 1][j] != nil
                                {
                                    arr[i][j]?.addConnections(to: [arr[i+1][j]!], bidirectional: true)
                                }
                            }
                            else
                            {
                                // up
                                if arr[i-1][j] != nil
                                {
                                    arr[i][j]?.addConnections(to: [arr[i-1][j]!], bidirectional: true)
                                }
                                
                                if j == 0
                                {
                                    // right
                                    if arr[i][j+1] != nil
                                    {
                                        arr[i][j]?.addConnections(to: [arr[i][j+1]!], bidirectional: true)
                                    }
                                }
                                else
                                {
                                    // left
                                    if arr[i][j-1] != nil
                                    {
                                        arr[i][j]?.addConnections(to: [arr[i][j-1]!], bidirectional: true)
                                    }
                                }
                            }
                        }
                    }
                }
                
                resultPath = myGraph.findPath(from: startNode!, to: endNode!)
                for i in 0...resultPath.count-1
                {
                    let g: GraphNode = (resultPath[i] as! GraphNode)
                    actions.append(SKAction.move(to: CGPoint(x: CGFloat(g.row+1) * scaleX, y: CGFloat(g.col+1) * scaleY), duration: 3.0))
                }
                
                print(resultPath)
                
            } catch let error as NSError {
                print("Failed reading from URL: \(path), Error: " + error.localizedDescription)
            }
        }
    }
}
