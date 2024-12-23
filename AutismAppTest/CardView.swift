//
//  CardView.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 17/06/1446 AH.
//


import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack {
            Text(card.emoji) // عرض الإيموجي
                .font(.system(size: 50))
            Text(card.cardDescription)  // عرض وصف البطاقة
                .font(.body)
                .padding(.top, 5)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)  // جعل البطاقة تأخذ المساحة المتاحة
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))  // إضافة خلفية
        .padding(.bottom, 10)
    }
}


