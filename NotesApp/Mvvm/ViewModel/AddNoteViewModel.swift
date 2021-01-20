//
//  AddNoteViewModel.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/16/21.
//
import Foundation
import CoreData

class AddNoteViewModel {
    func saveNote(titleNote: String,bodyNote: String,colorNote: String,dateNote: String, complation: @escaping(Bool)-> Void){
        let note = NoteModel(context: context)
        note.titleNote = titleNote
        note.bodyNote = bodyNote
        note.colorNote = colorNote
        note.dateNote = dateNote
        do {
            try context.save()
            complation(true)
        } catch{
            complation(false)
        }
    }
}
