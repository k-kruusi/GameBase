//
//  GraphNode.swift
//  XPaceInvaders
//
//  Created by Fonseca Barbalho Talis on 3/22/18.
//  Copyright © 2018 Fonseca Barbalho Talis. All rights reserved.
//
// modified from https://medium.com/swiftly-swift/the-right-way-to-write-dijkstras-algorithm-in-swift-abb14ce66b00

import Foundation
import GameplayKit

class GraphNode: GKGraphNode {
    let row: Int
    let col: Int
    
    var travelCost: [GKGraphNode: Float] = [:]
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.row = -1
        self.col = -1
        super.init()
    }
    
    override func cost(to node: GKGraphNode) -> Float {
        return travelCost[node] ?? 0
    }
    
    func addConnection(to node: GKGraphNode, bidirectional: Bool = true, weight: Float) {
        self.addConnections(to: [node], bidirectional: bidirectional)
        travelCost[node] = weight
        guard bidirectional else { return }
        (node as? GraphNode)?.travelCost[self] = weight
    }
}
