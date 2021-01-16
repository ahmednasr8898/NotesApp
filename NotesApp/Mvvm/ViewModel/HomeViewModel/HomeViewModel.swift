//
//  HomeViewModel.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/16/21.
//
import Foundation
import CoreData
import RxSwift
import RxCocoa

class HomeViewModel{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notes = BehaviorRelay<[NoteModel]>(value: [])
    var fetchData: Observable<[NoteModel]> {
       return Observable.deferred { [unowned self] in
          return Observable.just(try! self.context.fetch(NoteModel.fetchRequest()))
       }.do(onNext: { [unowned self] data in
          self.notes.accept(data)
       })
    }
}
