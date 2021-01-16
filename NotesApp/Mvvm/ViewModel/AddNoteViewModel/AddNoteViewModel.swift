//
//  AddNoteViewModel.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/16/21.
//
import Foundation
import CoreData
import RxSwift
import RxCocoa

class AddNoteViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var titleBehavior = BehaviorRelay<String>(value: "")
    var bodyBehavior = BehaviorRelay<String>(value: "")
    var colorBehavior = BehaviorRelay<String>(value: "")
    var dateBehavior = BehaviorRelay<String>(value: "")
    
    func saveNote(){
        let noteModel = NoteModel(context: self.context)
        noteModel.titleNote = titleBehavior.value
        noteModel.bodyNote = bodyBehavior.value
        noteModel.colorNote = colorBehavior.value
        noteModel.dateNote = dateBehavior.value
        do {
            try context.save()
            print("Success to save new note")
        } catch let error {
            print("error when save new note",error.localizedDescription)
        }
    }
}
