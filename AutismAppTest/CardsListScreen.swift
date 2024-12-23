//
//  CardsListScreen.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 21/06/1446 AH.
//

import SwiftUI
import SwiftData

struct CardsListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var file: File
    @State private var showingNewCardSheet = false
    @State private var showingEditCardSheet = false  // حالة لعرض نافذة تعديل البطاقة
    @State private var cardToEdit: Card?  // العنصر الذي سيتم تعديله
    @State private var showingDeleteConfirmation = false  // حالة لعرض التنبيه
    @State private var cardToDelete: Card?  // العنصر الذي سيتم حذفه

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(file.cards) { card in
                        HStack {
                            CardView(card: card)
                            
                            // زر تعديل
                            Button(action: {
                                cardToEdit = card  // تعيين البطاقة التي سيتم تعديلها
                                showingEditCardSheet.toggle()  // إظهار نافذة التعديل
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                                    .padding(8)
                            }
                            
                            // زر حذف
                            Button(action: {
                                cardToDelete = card  // تعيين البطاقة التي سيتم حذفها
                                showingDeleteConfirmation = true  // إظهار التنبيه للحذف
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding(8)
                            }
                        }
                    }
                }
                .padding()
            }
            
            Button(action: {
                showingNewCardSheet.toggle()
            }) {
                Text("Add New Card")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $showingNewCardSheet) {
                NewCard(file: $file)
            }
        }
        .navigationTitle(file.title)
        .onAppear {
            loadCards()
        }
        // نافذة تعديل البطاقة
        .sheet(isPresented: $showingEditCardSheet) {
            if let cardToEdit = cardToEdit {
                EditCard(card: cardToEdit) { updatedCard in
                    if let index = file.cards.firstIndex(where: { $0.id == updatedCard.id }) {
                        file.cards[index] = updatedCard  // تحديث البطاقة في القائمة
                    }
                }
            }
        }
        // التنبيه الذي يطلب تأكيد الحذف
        .alert(isPresented: $showingDeleteConfirmation) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Do you really want to delete this card? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    if let cardToDelete = cardToDelete {
                        deleteCard(cardToDelete)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func loadCards() {
        // يمكنك هنا إضافة طريقة لتحميل البطاقات إذا كان هناك حاجة
    }

    // دالة لحذف البطاقة
    private func deleteCard(_ card: Card) {
        if let index = file.cards.firstIndex(where: { $0.id == card.id }) {
            file.cards.remove(at: index)
        }
        
        modelContext.delete(card)
        
        do {
            try modelContext.save()
        } catch {
            print("Error deleting card: \(error.localizedDescription)")
        }
    }
}
