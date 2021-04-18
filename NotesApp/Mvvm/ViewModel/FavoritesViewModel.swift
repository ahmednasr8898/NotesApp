//
//  FavoritesViewModel.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/26/21.
//
import Foundation

class FavoritesViewModel{
    func fetchData(complation: @escaping ([FavoriteModel])->Void){
        let notes = try! context.fetch(FavoriteModel.fetchRequest())
        complation(notes as! [FavoriteModel])
    }
    func deleteNote(noteSelected: FavoriteModel, complation: @escaping(Bool)-> Void){
        context.delete(noteSelected)
        do{
            try context.save()
            complation(true)
        }catch{
            complation(false)
        }
    }
    func backToHome(titleNote: String,bodyNote: String,colorNote: String,dateNote: String, complation: @escaping(Bool)-> Void){
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
