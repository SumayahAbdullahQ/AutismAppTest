//
//  Card.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 17/06/1446 AH.
//

import SwiftData
import Foundation

@Model
class Card: Identifiable {
    var id: UUID
    var emoji: String
    var cardDescription: String
    @Relationship(inverse: \File.cards) var file: File? // العلاقة العكسية مع File

    init(emoji: String, cardDescription: String) {
        self.id = UUID()
        self.emoji = emoji
        self.cardDescription = cardDescription
    }
}

