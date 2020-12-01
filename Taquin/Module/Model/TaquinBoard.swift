//
//  TaquinBoard.swift
//  Taquin
//
//  Created by Oussama Zroud on 11/29/20.
//  Copyright © 2020 Oussama Zroud. All rights reserved.
//

import Foundation

class TaquinBoard {
    
    // MARK: - PROPERTIES
    var matrix: [[Int]] = [ [1, 2, 3, 4],
                            [5, 6, 7 ,8],
                            [9, 10, 11, 12],
                            [13, 14, 15, 0] ]
    let row = 4
    let column = 4
    
    init(numShuffle: Int){
        self.shuffle(numTimes: numShuffle)
    }
    
    //  MARK: - FUNCTIONS
    func random(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    func swap(fromRow r1: Int, Column c1: Int, toRow r2: Int, Column c2: Int) {
        matrix[r2][c2] = matrix[r1][c1]
        matrix[r1][c1] = 0
    }
    
    func shuffle(numTimes n: Int) {
        resetBoard()
        for _ in 1...n {
            var movingTiles : [(atRow: Int, Column: Int)] = []
            var numMovingTiles : Int = 0
            for r in 0..<row {
                for c in 0..<column {
                    if canSlide(atRow: r, Column: c) {
                        movingTiles.append((r, c))
                        numMovingTiles = numMovingTiles + 1
                    }
                }
            }
            let randomTile = random(numMovingTiles)
            var moveRow : Int, moveCol : Int
            (moveRow , moveCol) = movingTiles[randomTile]
            slide(atRow: moveRow, Column: moveCol)
        }
    }
    
    func getTile(atRow r: Int, atColumn c: Int) -> Int {
        return matrix[r][c]
    }
    
    func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
        if (tile > (row*column-1)) {
            return nil
        }
        for x in 0..<row {
            for y in 0..<column {
                if ((matrix[x][y]) == tile) {
                    return (row: x,column: y)
                }
            }
        }
        return nil
    }
    
    func canSlideUp(atRow r : Int, Column c : Int) -> Bool {
        return (r < 1) ? false : ( matrix[r-1][c] == 0 )
    }
    
    func canSlideDown(atRow r :  Int, Column c :  Int) -> Bool {
        return (r > (row-2)) ? false : ( matrix[r+1][c] == 0 )
    }
    
    func canSlideLeft(atRow r :  Int, Column c :  Int) -> Bool {
        return (c < 1) ? false : ( matrix[r][c-1] == 0 )
    }
    
    func canSlideRight(atRow r :  Int, Column c :  Int) -> Bool {
        return (c > (column-2)) ? false : ( matrix[r][c+1] == 0 )
    }
    
    func canSlide(atRow r :  Int, Column c :  Int) -> Bool {
        return  (canSlideRight(atRow: r, Column: c) ||
            canSlideLeft(atRow: r, Column: c) ||
            canSlideDown(atRow: r, Column: c) ||
            canSlideUp(atRow: r, Column: c))
    }
    
    func slide(atRow r: Int, Column c: Int) {
        if (r > row || c > column || r < 0 || c < 0) {
            return
        }
        if (canSlide(atRow: r, Column: c)) {
            if (canSlideUp(atRow: r, Column: c)) {
                swap(fromRow: r, Column: c, toRow: r-1, Column: c)
            }
            if (canSlideDown(atRow: r, Column: c)) {
                swap(fromRow: r, Column: c, toRow: r+1, Column: c)
            }
            if (canSlideLeft(atRow: r, Column: c)) {
                swap(fromRow: r, Column: c, toRow: r, Column: c-1)
            }
            if (canSlideRight(atRow: r, Column: c)) {
                swap(fromRow: r, Column: c, toRow: r, Column: c+1)
            }
        }
    }
    
    func isSolved() -> Bool {
        var comparison = 1
        for r in 0..<row {
            for c in 0..<column {
                if matrix[r][c] != comparison%16 {
                    return false
                } // end if
                comparison = comparison + 1
            }
        }
        return true
    }
    
    func resetBoard() {
        var set = 1
        for r in 0..<row {
            for c in 0..<column {
                matrix[r][c] = set%16
                set = set + 1
            }
        }
    }
}
