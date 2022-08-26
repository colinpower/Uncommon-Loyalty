//
//  RewardCard.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 8/26/22.
//

import Foundation

import SwiftUI

//MARK: Sample card model and data
struct RewardCard: Identifiable {
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
}

var cards: [RewardCard] = [

    RewardCard(name: "colin", cardNumber: "1", cardImage: "AthleisureFounder"),
    RewardCard(name: "joseph", cardNumber: "2", cardImage: "AthleisureFounder"),
    RewardCard(name: "power", cardNumber: "3", cardImage: "AthleisureFounder")

]
