//
//  EditCard.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 22/06/1446 AH.
//

import SwiftUI

struct EditCard: View {
    @Environment(\.modelContext) private var modelContext
    @State private var emoji: String
    @State private var description: String
    var card: Card
    var onSave: (Card) -> Void  // Closure لتمرير التغييرات

    init(card: Card, onSave: @escaping (Card) -> Void) {
        _emoji = State(initialValue: card.emoji)
        _description = State(initialValue: card.cardDescription)
        self.card = card
        self.onSave = onSave
    }

    var body: some View {
        VStack {
            TextField("Enter Emoji", text: $emoji)  // حقل إدخال الإيموجي
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()

            TextField("Enter Description", text: $description)  // حقل إدخال الوصف
                .font(.title)
                .padding()

            Button("Save") {
                if !emoji.isEmpty && !description.isEmpty {
                    // تحديث البطاقة
                    card.emoji = emoji
                    card.cardDescription = description
                    
                    // حفظ التغييرات في الـ modelContext
                    do {
                        try modelContext.save()
                        onSave(card)  // تمرير البطاقة المعدلة إلى الـ parent view
                    } catch {
                        print("Error saving card: \(error.localizedDescription)")
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}

