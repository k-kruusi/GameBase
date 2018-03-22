//
//  Level.swift
//  XPaceInvaders
//
//  Created by Mazza Matthew J. on 3/8/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//

import Foundation
import GameplayKit

class Level : BaseGameObject{
    let myGraph = GKGraph()
    //put stuff here
    //this is for the grid
    func testLevelCreation()
    {
        var arr: [[Int]] = []
        if let path = Bundle.main.path(forResource: "level", ofType: "txt")
        {
            var readStringProject = ""
            do {
                readStringProject = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                var result: [String] = []
                readStringProject.enumerateLines {
                    (line, _) -> () in
                    result.append(line)
                }
                
                let levelName = result[0]
                let rowsColsArray = result[1].split(separator: " ")
                let rows : Int = Int(rowsColsArray[0])!
                let cols : Int = Int(rowsColsArray[1])!
                
                
                
                for i in 0...(rows-1)
                {
                    arr.append([])
                    
                    for j in 0...(cols-1)
                    {
                        arr[i].append(i+j)
                    }
                }
                
                print (arr)
                
            } catch let error as NSError {
                print("Failed reading from URL: \(path), Error: " + error.localizedDescription)
            }
            // trying to read from the file. I can't call the following function for some reason
            //let text = String.init(contentsOfFile: path, usedEncoding: nil)
            //print(readStringProject)
        }
    }
}
