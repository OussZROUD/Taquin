//
//  TaquinBoardView.swift
//  Taquin
//
//  Created by Oussama Zroud on 11/29/20.
//  Copyright © 2020 Oussama Zroud. All rights reserved.
//

import UIKit

class TaquinBoardView: UIView {
    
    // MARK: - PROPERTIES
    var taquinBoardViewModel: TaquinBoardViewModel?
        
    // MARK: - OVERRIDES
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let viewModel = taquinBoardViewModel else { return }
        let boardSquare = boardRect()
        let tileSize = (boardSquare.width) / 4.0
        let tileBounds = CGRect(x: 0, y: 0, width: tileSize, height: tileSize)
        for row in 0 ..< 4 {
            for column in 0 ..< 4 {
                let tile = viewModel.getTile(atRow: row, atColumn: column)
                if tile > 0 {
                    let button = self.viewWithTag(tile)
                    button!.bounds = tileBounds
                    button!.center = CGPoint(x: boardSquare.origin.x + (CGFloat(column) + 0.5)*tileSize,
                                             y: boardSquare.origin.y + (CGFloat(row) + 0.5)*tileSize)
                }
            }
        }
    }
    
    // MARK: - FUCTIONS
    func boardRect() -> CGRect {
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let margin : CGFloat = 0
        let size = ((width <= height) ? width : height) - margin
        let boardSize : CGFloat = CGFloat((Int(size) + 7)/8)*8.0
        let leftMargin = (width - boardSize)/2
        let topMargin = (width - boardSize)/2
        return CGRect(x: leftMargin, y: topMargin, width: boardSize, height: boardSize)
    }
    
}
