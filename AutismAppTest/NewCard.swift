//
//  NewCard.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 17/06/1446 AH.
//
import SwiftUI
import SwiftData

struct NewCard: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var file: File // مررنا الملف هنا
    @State private var emoji: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Emoji", text: $emoji)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .padding()
            
            TextField("Enter Description", text: $description)
                .font(.body)
                .disableAutocorrection(true)
                .padding()
            
            Button("Save") {
                if !emoji.isEmpty && !description.isEmpty {
                    // إنشاء كارد جديد
                    let newCard = Card(emoji: emoji, cardDescription: description)
                    
                    // إضافة الكارد إلى الملف
                    file.cards.append(newCard)
                    
                    // إضافة الكارد إلى الـ modelContext
                    modelContext.insert(newCard)
                    
                    // حفظ التغييرات في الـ modelContext
                    do {
                        try modelContext.save()
                        
                        // بعد حفظ الكارد، نعيد تعيين القيم المدخلة
                        emoji = ""
                        description = ""
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

