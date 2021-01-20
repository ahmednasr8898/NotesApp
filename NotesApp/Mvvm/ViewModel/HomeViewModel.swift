//
//  HomeViewModel.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/16/21.
//
import Foundation
import CoreData

class HomeViewModel{
    func fetchData(complation: @escaping ([NoteModel])->Void){
        let notes = try! context.fetch(NoteModel.fetchRequest())
        complation(notes as! [NoteModel])
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
    func searchOnTableView(titleNote: String, complation: @escaping([NoteModel]?)->Void){
        let predicate = NSPredicate(format: "titleNote contains %@", titleNote)
        let request:NSFetchRequest = NoteModel.fetchRequest()
        request.predicate = predicate
        do {
            let data = try (context.fetch(request))
            complation(data)
        } catch {
            print("error in searchOnTableView Function:", error.localizedDescription)
        }
    }
}
