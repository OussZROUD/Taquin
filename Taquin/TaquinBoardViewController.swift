//
//  TaquinBoardViewController.swift
//  Taquin
//
//  Created by Oussama Zroud on 11/29/20.
//  Copyright © 2020 Oussama Zroud. All rights reserved.
//

import UIKit

protocol ViewModelToViewDelegate {
    func doSlideAnnimation(from button:UIButton, to point: CGPoint )
    func doSolvedAnnimation()
}

class TaquinBoardViewController: UIViewController, ViewModelToViewDelegate {
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var taquinBoardView: TaquinBoardView!
    
    // MARK: - PROPERTIES
    var taquinBoardViewModel = TaquinBoardViewModel()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        taquinBoardViewModel.delegate = self
        taquinBoardView.taquinBoardViewModel = taquinBoardViewModel
    }
    
    // MARK: - ACTIONS
    @IBAction func swipeButton(_ sender: UIButton) {
        taquinBoardViewModel.swipe(button: sender)
    }
    
    @IBAction func shuffleButtonAction(_ sender: Any) {
        taquinBoardViewModel.shuffle()
        self.taquinBoardView.setNeedsLayout()
    }
    
    // MARK: - VIEWMODEL TO VIEW METHODS
    func doSlideAnnimation(from button: UIButton, to point: CGPoint) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {button.center = point})
    }
    
    func doSolvedAnnimation() {
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.view.window!.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.45, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            self.view.window!.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
    }
}

