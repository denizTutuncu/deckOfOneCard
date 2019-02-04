//
//  Deck+Card.swift
//  Deck_Of_One_Card
//
//  Created by Deniz Tutuncu on 2/4/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let value: String
    let suit: String
    let image: String
}
