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
    func deleteNote(noteSelected: NoteModel, complation: @escaping(Bool)-> Void){
        context.delete(noteSelected)
        do{
            try context.save()
            complation(true)
        }catch{
            complation(false)
        }
    }
    func deleteNoteFav(noteSelected: FavoriteModel, complation: @escaping(Bool)-> Void){
        context.delete(noteSelected)
        do{
            try context.save()
            complation(true)
        }catch{
            complation(false)
        }
    }
    func editNote(selectedNote: NoteModel ,titleNote: String,bodyNote: String,colorNote: String,dateNote: String, complation: @escaping(Bool)-> Void){
        selectedNote.titleNote = titleNote
        selectedNote.bodyNote = bodyNote
        selectedNote.colorNote = colorNote
        selectedNote.dateNote = dateNote
        do {
            try context.save()
            complation(true)
        } catch{
            complation(false)
        }
    }
    func editNoteInFav(selectedNote: FavoriteModel ,titleNote: String,bodyNote: String,colorNote: String,dateNote: String, complation: @escaping(Bool)-> Void){
        selectedNote.title = titleNote
        selectedNote.body = bodyNote
        selectedNote.color = colorNote
        selectedNote.date = dateNote
        do {
            try context.save()
            complation(true)
        } catch{
            complation(false)
        }
    }
}
