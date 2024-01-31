//
//  ListItems+CoreDataProperties.swift
//  ToDoList
//
//  Created by zoho on 24/01/24.
//
//

import Foundation
import CoreData


extension ListItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItems> {
        return NSFetchRequest<ListItems>(entityName: "ListItems")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var work: String?

}

extension ListItems : Identifiable {

}
