//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by zoho on 24/01/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "Notes")
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load() {
        persistentContainer.loadPersistentStores {
            (desc, err) in
            guard err == nil else{
                fatalError("Error occured during connection")
            }
            print("Data loaded succesfully")
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            }
            catch {
                fatalError("Error occured while saving")
            }
        }
    }
    
    func createNote(note: String, date: Date) -> Tasks{
        let task = Tasks(context: viewContext)
        task.id = UUID()
        task.lastlyUpdated = date
        task.notes = note
        task.isCompleted = false
        task.isstarred = false
        save()
        return task
    }
    
    func fetchNotes() -> [Tasks] {
        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "lastlyUpdated", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func updateTaskCompleted(_ task: Tasks) -> Tasks{
        print("In core data", task.isCompleted)
        task.isCompleted = !task.isCompleted
        save()
        return task
    }
    
    func deleteTask(_ task: Tasks) {
        viewContext.delete(task)
        save()
    }
    
    func fetchTasksWithLimitAndOffset(limit: Int, offset: Int) -> [Tasks] {
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
            fetchRequest.fetchLimit = limit
            fetchRequest.fetchOffset = offset
            do {
                let result = try viewContext.fetch(fetchRequest)
                return result
            } catch {
                print("Error fetching data: \(error)")
                return []
            }
        }
}
