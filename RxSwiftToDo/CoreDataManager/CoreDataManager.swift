//
//  CoreDataManager.swift
//  RxSwiftToDo
//
//  Created by gdml on 18/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import CoreData
import RxCocoa
import RxSwift

class CoreDataManager {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let background = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    
    var coreDataModel = BehaviorRelay<[ToDo]>(value: [])
    
    private func fetchData() -> [ToDo] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ToDo.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try context.fetch(fetchRequest) as! [ToDo]
        } catch {
            return []
        }
        
    }
    
    public func fetchObservableData() -> Observable<[ToDo]> {
        coreDataModel.accept(fetchData())
        return coreDataModel.asObservable()
    }
    
    public func addTodo(withTodo todo: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context) as! ToDo
        newTodo.name = todo
        background.perform {
        do {
            try self.context.save()
            self.coreDataModel.accept(self.fetchData())
        } catch {
            fatalError("error saving data")
        }
    }
}
    public func removeTodo(withIndex index: Int) {
        context.delete(coreDataModel.value[index])
        background.perform {
        do {
            try self.context.save()
            self.coreDataModel.accept(self.fetchData())
        } catch {
            fatalError("error delete data")
        }
        }
    }
    
}
