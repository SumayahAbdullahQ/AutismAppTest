//
//  File.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 21/06/1446 AH.
//

import SwiftData
import Foundation

@Model
class File: Identifiable {
    var id: UUID
    var title: String
    var emoji: String  // إضافة حقل الإيموجي هنا
    @Relationship var cards: [Card] // علاقة one-to-many بين File و Card

    init(title: String, emoji: String) {
        self.id = UUID()
        self.title = title
        self.emoji = emoji  // تهيئة الإيموجي
        self.cards = [] // البطاقات تبدأ كقائمة فارغة
    }
}


