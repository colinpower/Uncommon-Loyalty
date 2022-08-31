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

    RewardCard(name: "colin", cardNumber: "1", cardImage: "AthleisureLA-Gold-Discount"),
    RewardCard(name: "joseph", cardNumber: "2", cardImage: "AthleisureLA-Member-Discount"),
    RewardCard(name: "power", cardNumber: "3", cardImage: "AthleisureLA-Gold-Discount"),
    RewardCard(name: "colin", cardNumber: "4", cardImage: "AthleisureLA-Platinum-Discount"),
    RewardCard(name: "colin", cardNumber: "4", cardImage: "AthleisureLA-Platinum-Loyalty"),
    RewardCard(name: "power", cardNumber: "9", cardImage: "GoldenRatioCard"),
    RewardCard(name: "joseph", cardNumber: "5", cardImage: "AthleisureFounder"),
    RewardCard(name: "power", cardNumber: "6", cardImage: "AthleisureLA-No-Discount")
]
