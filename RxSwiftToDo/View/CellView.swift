//
//  CellViewModel.swift
//  RxSwiftToDo
//
//  Created by gdml on 19/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation
import UIKit

class CellView: UITableViewCell {
    override func awakeFromNib() {
           super.awakeFromNib()
       }
    func viewModel(_ byViewModel: ToDo) {
        textLabel?.text = byViewModel.name
    }
}
