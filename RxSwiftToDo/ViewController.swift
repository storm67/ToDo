//
//  ViewController.swift
//  RxSwiftToDo
//
//  Created by gdml on 18/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var addButton: UIBarButtonItem!
    var disposeBag = DisposeBag()
    var viewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.title = "Add"
        self.navigationItem.rightBarButtonItem?.title = "Add"
        simple()
        setupActionWhenButtonAddTodoTapped()
    }
    
    fileprivate func simple() {
        let observer = viewModel.toDoModel.asObservable()
        observer.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element.name
        }.disposed(by: disposeBag)
    }
    
    func setupActionWhenButtonAddTodoTapped() {
        addButton.rx.tap
            .subscribe(
                onNext: {
                    let addTodoAlert = UIAlertController(title: "Add Todo", message: "Enter your string", preferredStyle: .alert)

                    addTodoAlert.addTextField(configurationHandler: nil)
                    addTodoAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { al in
                        let todoString = addTodoAlert.textFields![0].text
                        if !(todoString!.isEmpty) {
                            self.viewModel.addTodo(withTodo: todoString!)
                        }
                    }))

                    addTodoAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

                    self.present(addTodoAlert, animated: true, completion: nil)
                }
            )
            .disposed(by: disposeBag)
    }
}

