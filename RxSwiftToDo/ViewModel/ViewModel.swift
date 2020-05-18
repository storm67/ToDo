//
//  ViewModel.swift
//  RxSwiftToDo
//
//  Created by gdml on 18/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class ViewModel: NSObject {
    var coreDataManager: CoreDataManager
    let toDoModel = BehaviorRelay<[ToDo]>(value: [])
    let disposeBag: DisposeBag
    
    override init() {
        disposeBag = DisposeBag()
        coreDataManager = CoreDataManager()
        super.init()
        returnData()
       }
    
    private func returnData() {
        coreDataManager.fetchObservableData()
            .asObservable()
            .subscribe(onNext: { todos in
                self.toDoModel.accept(todos)
            })
            .disposed(by: disposeBag)
    }
    
    public func removeTodo(withIndex index: Int) {
        coreDataManager.removeTodo(withIndex: index)
    }
    
    public func addTodo(withTodo todo: String) {
        coreDataManager.addTodo(withTodo: todo)
    }
    
    public func cellViewModel(index: Int) -> ToDo {
        guard index < toDoModel.value.count else { return ToDo()}
        return toDoModel.value[index]
       }
   }


