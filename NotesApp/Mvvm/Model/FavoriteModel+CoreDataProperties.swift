//
//  FavoriteModel+CoreDataProperties.swift
//  NotesApp
//
//  Created by Ahmed Nasr on 1/26/21.
//
//

import Foundation
import CoreData


extension FavoriteModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteModel> {
        return NSFetchRequest<FavoriteModel>(entityName: "FavoriteModel")
    }

    @NSManaged public var body: String?
    @NSManaged public var color: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?

}

extension FavoriteModel : Identifiable {

}
