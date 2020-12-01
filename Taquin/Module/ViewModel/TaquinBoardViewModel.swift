//
//  TaquinBoardViewModel.swift
//  Taquin
//
//  Created by Oussama Zroud on 11/30/20.
//  Copyright © 2020 Oussama Zroud. All rights reserved.
//

import UIKit

class TaquinBoardViewModel {
    
    // MARK: - PROPERTIES
    private var taquinBoardModel: TaquinBoard? = {
        return TaquinBoard(numShuffle: 100)
    }()
    var delegate: ViewModelToViewDelegate?
    
    // MARK: - INTENTS
    func swipe(button: UIButton) {
        guard let model = taquinBoardModel else { return }
        guard let position = model.getRowAndColumn(forTile: button.tag) else { return }
        let buttonBounds = button.bounds
        var buttonCenter = button.center
        var slide = true
        
        if model.canSlideUp(atRow: position.row, Column: position.column) {
            buttonCenter.y -= buttonBounds.size.height
        } else if model.canSlideDown(atRow: position.row, Column: position.column) {
            buttonCenter.y += buttonBounds.size.height
        } else if model.canSlideLeft(atRow: position.row, Column: position.column) {
            buttonCenter.x -= buttonBounds.size.width
        } else if model.canSlideRight(atRow: position.row, Column: position.column) {
            buttonCenter.x += buttonBounds.size.width
        } else {
            slide = false
        }
        if slide {
            model.slide(atRow: position.row, Column: position.column)
            delegate?.doSlideAnnimation(from: button, to: buttonCenter)
            
            if model.isSolved() {
                delegate?.doSolvedAnnimation()
            }
        }
    }
    
    func shuffle() {
        guard let model = taquinBoardModel else { return }
        model.shuffle(numTimes: 100)
    }
    
    func getTile(atRow r: Int, atColumn c: Int) -> Int {
        guard let model = taquinBoardModel else { return  0 }
        return model.getTile(atRow:r, atColumn: c)
    }
}
