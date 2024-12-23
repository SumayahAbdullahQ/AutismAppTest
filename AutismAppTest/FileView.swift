//
//  FileView.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 21/06/1446 AH.
//

import SwiftUI

struct FileView: View {
    var file: File
    
    var body: some View {
        VStack {
            Text(file.emoji)  // عرض الإيموجي
                .font(.system(size: 50))  // تكبير حجم الإيموجي
                .padding(.bottom, 5)
            
            Text(file.title)  // عرض عنوان الملف
                .font(.headline)
                .padding(.bottom, 5)
            
            // إضافة تفاصيل إضافية عن الملف إذا لزم الأمر
        }
        .frame(maxWidth: .infinity)  // جعل الملف يملأ العرض
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))  // خلفية مع حواف مستديرة
    }
}

