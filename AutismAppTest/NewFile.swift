//
//  NewFile.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 21/06/1446 AH.
//

import SwiftUI
import SwiftData

struct NewFile: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var files: [File] // لإعادة تحميل الملفات بعد إضافة ملف جديد
    @State private var title: String = ""
    @State private var emoji: String = ""  // حقل الإيموجي الجديد
    
    var body: some View {
        VStack {
            TextField("Enter Emoji", text: $emoji)  // حقل إدخال الإيموجي
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .padding()
            
            TextField("Enter File Name", text: $title)  // حقل إدخال عنوان الملف
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .padding()
            
            Button("Save") {
                if !title.isEmpty && !emoji.isEmpty {
                    // إنشاء ملف جديد مع الإيموجي
                    let newFile = File(title: title, emoji: emoji)
                    
                    // إضافة الملف إلى الـ modelContext
                    modelContext.insert(newFile)
                    
                    // حفظ التغييرات في الـ modelContext
                    do {
                        try modelContext.save()
                        
                        // بعد حفظ الملف، نحدث قائمة الملفات في الـ parent view
                        files.append(newFile)
                        
                        // إعادة تعيين القيم المدخلة
                        title = ""
                        emoji = ""
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
