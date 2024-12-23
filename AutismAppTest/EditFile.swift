//
//  EditFile.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 22/06/1446 AH.
//

import SwiftUI

struct EditFile: View {
    @Environment(\.modelContext) private var modelContext
    @State private var title: String
    @State private var emoji: String
    var file: File
    var onSave: (File) -> Void  // Closure لتمرير التغييرات

    init(file: File, onSave: @escaping (File) -> Void) {
        _title = State(initialValue: file.title)
        _emoji = State(initialValue: file.emoji)
        self.file = file
        self.onSave = onSave
    }

    var body: some View {
        VStack {
            TextField("Enter Emoji", text: $emoji)  // حقل إدخال الإيموجي
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()

            TextField("Enter File Name", text: $title)  // حقل إدخال عنوان الملف
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()

            Button("Save") {
                if !title.isEmpty && !emoji.isEmpty {
                    // تحديث الملف
                    file.title = title
                    file.emoji = emoji
                    
                    // حفظ التغييرات في الـ modelContext
                    do {
                        try modelContext.save()
                        onSave(file)  // تمرير الملف المعدل إلى الـ parent view
                    } catch {
                        print("Error saving file: \(error.localizedDescription)")
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
