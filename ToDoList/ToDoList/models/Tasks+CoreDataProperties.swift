//
//  Tasks+CoreDataProperties.swift
//  ToDoList
//
//  Created by zoho on 24/01/24.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var notes: String?
    @NSManaged public var lastlyUpdated: Date?
    @NSManaged public var isstarred: Bool
    @NSManaged public var isCompleted: Bool

}

extension Tasks : Identifiable {

}
