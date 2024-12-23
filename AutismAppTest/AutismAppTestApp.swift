//
//  AutismAppTestApp.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 17/06/1446 AH.
//

import SwiftUI
import SwiftData

@main
struct AutismAppTestApp: App {
    var body: some Scene {
        WindowGroup {
            FilesScreen()
                .modelContainer(for: Card.self) // تحديد الـ model container لـ Card
        }
    }
}
