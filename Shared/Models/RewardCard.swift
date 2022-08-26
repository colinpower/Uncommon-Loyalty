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
    RewardCard(name: "power", cardNumber: "3", cardImage: "GoldenRatioCard"),
    RewardCard(name: "colin", cardNumber: "4", cardImage: "BlueGoldenRatio"),
    RewardCard(name: "joseph", cardNumber: "5", cardImage: "AthleisureFounder"),
    RewardCard(name: "power", cardNumber: "6", cardImage: "GoldenRatioCard"),
    RewardCard(name: "colin", cardNumber: "7", cardImage: "AthleisureFounder"),
    RewardCard(name: "joseph", cardNumber: "8", cardImage: "AthleisureFounder"),
    RewardCard(name: "power", cardNumber: "9", cardImage: "GoldenRatioCard"),
    RewardCard(name: "colin", cardNumber: "10", cardImage: "AthleisureFounder"),
    RewardCard(name: "joseph", cardNumber: "11", cardImage: "AthleisureFounder"),
    RewardCard(name: "power", cardNumber: "12", cardImage: "GoldenRatioCard")

]
