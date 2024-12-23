//
//  FilesScreen.swift
//  AutismAppTest
//
//  Created by Sumayah Alqahtani on 22/06/1446 AH.
//

import SwiftUI
import SwiftData

struct FilesScreen: View {
    @Environment(\.modelContext) private var modelContext
    @State private var files: [File] = []
    @State private var showingNewFileSheet = false
    @State private var showingEditFileSheet = false  // حالة لعرض نافذة تعديل الملف
    @State private var fileToEdit: File?  // العنصر الذي سيتم تعديله
    @State private var showingDeleteConfirmation = false  // حالة لعرض التنبيه
    @State private var fileToDelete: File?  // العنصر الذي سيتم حذفه

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach($files) { $file in
                            HStack {
                                NavigationLink(destination: CardsListScreen(file: $file)) {
                                    FileView(file: file)
                                }
                                
                                // زر تعديل
                                Button(action: {
                                    fileToEdit = file  // تعيين الملف الذي سيتم تعديله
                                    showingEditFileSheet.toggle()  // إظهار نافذة التعديل
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.blue)
                                        .padding(8)
                                }
                                
                                // زر حذف
                                Button(action: {
                                    fileToDelete = file  // تعيين الملف الذي سيتم حذفه
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
                .navigationTitle("Files")
                .navigationBarItems(trailing: Button(action: {
                    showingNewFileSheet.toggle()
                }) {
                    Text("New File")
                        .font(.headline)
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .sheet(isPresented: $showingNewFileSheet) {
                    NewFile(files: $files)
                }
            }
            .onAppear {
                loadFiles()
            }
            // نافذة تعديل الملف
            .sheet(isPresented: $showingEditFileSheet) {
                if let fileToEdit = fileToEdit {
                    EditFile(file: fileToEdit) { updatedFile in
                        if let index = files.firstIndex(where: { $0.id == updatedFile.id }) {
                            files[index] = updatedFile  // تحديث الملف في القائمة
                        }
                    }
                }
            }
            // التنبيه الذي يطلب تأكيد الحذف
            .alert(isPresented: $showingDeleteConfirmation) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Do you really want to delete this file? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let fileToDelete = fileToDelete {
                            deleteFile(fileToDelete)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    private func loadFiles() {
        do {
            let fetchDescriptor = FetchDescriptor<File>()
            let filesFetch = try modelContext.fetch(fetchDescriptor)
            files = filesFetch.sorted { $0.title < $1.title }
        } catch {
            print("Error loading files: \(error.localizedDescription)")
        }
    }
    
    private func deleteFile(_ file: File) {
        modelContext.delete(file)
        
        do {
            try modelContext.save()
            loadFiles()  // إعادة تحميل الملفات بعد الحذف
        } catch {
            print("Error deleting file: \(error.localizedDescription)")
        }
    }
}
