//
//  NightVC.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-28.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import UIKit

protocol EndNightPotocol: class {
    func endNight()
}

class NightVC: TisprCardStackViewController, TisprCardStackViewControllerDelegate {

    weak var endNightDelegate: EndNightPotocol?
    let temp = 6
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set animation speed
        setAnimationSpeed(0.85)
        
        //set size of cards
        let size = CGSize(width: view.bounds.width - 40, height: view.bounds.height*0.8)
        setCardSize(size)
        
        cardStackDelegate = self
        
        //configuration of stacks
        layout.topStackMaximumSize = 2
        layout.bottomStackMaximumSize = 4
        layout.bottomStackCardHeight = 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Tispr functions
    
    override func numberOfCards() -> Int {
        
        if GAME.firstNight {
            return GAME.availableRoster.count
        }
        
        return GAME.nightActors.count
    }
    
    override func card(_ collectionView: UICollectionView, cardForItemAtIndexPath indexPath: IndexPath) -> TisprCardStackViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NightCell", for: indexPath as IndexPath) as! NightCell
        
        if GAME.firstNight {
            cell.role = GAME.availableRoster[indexPath.row]
        } else {
            cell.player = GAME.nightActors[indexPath.row]
        }
        
        cell.configureCell()
        
        return cell
    }
    
    func cardDidChangeState(_ cardIndex: Int) {
        collectionView?.reloadData()
        
        if GAME.firstNight {
//            if checkPlayerAssignment() {
//                
//            }
            if cardIndex == GAME.availableRoster.count {
                endNight()
            }
        } else {
            if cardIndex == GAME.nightActors.count {
                endNight()
            }
        }
    }
    
    func checkPlayerAssignment() -> Bool {
        
        return true
    }
    
    func endNight() {
        self.endNightDelegate?.endNight()
    }
}
