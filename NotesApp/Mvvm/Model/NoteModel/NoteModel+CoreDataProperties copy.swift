//
//  NoteModel+CoreDataProperties.swift
//  
//
//  Created by Ahmed Nasr on 1/16/21.
//
//
import Foundation
import CoreData

extension NoteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteModel> {
        return NSFetchRequest<NoteModel>(entityName: "NoteModel")
    }

    @NSManaged public var titleNote: String?
    @NSManaged public var bodyNote: String?
    @NSManaged public var colorNote: String?
    @NSManaged public var dateNote: String?
}
