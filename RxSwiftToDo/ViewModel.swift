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

class ViewModel {
    var coreDataManager = CoreDataManager()
    let toDoModel = BehaviorRelay<[ToDo]>(value: [])
    let disposeBag = DisposeBag()
    
    init() {
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
    
    public func addTodo(withTodo todo: String) {
        coreDataManager.addTodo(withTodo: todo)
    }
}

