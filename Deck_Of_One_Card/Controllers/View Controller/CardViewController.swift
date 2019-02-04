//
//  CardViewController.swift
//  Deck_Of_One_Card
//
//  Created by Deniz Tutuncu on 2/4/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var drawCardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func drawCard() {
        CardController.drawCard(numberOfCard: 1) { (cards) in
            let card = cards[0]
            CardController.image(forURL: card.image, completion: { (cardImage) in
                guard let image = cardImage else { return }
                self.cardImageView.image = image
            })
        }
    }
    
    @IBAction func drawCardButtonTapped(_ sender: UIButton) {
        drawCard()
    }
}
