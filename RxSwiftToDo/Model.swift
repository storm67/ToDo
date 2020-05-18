//
//  Model.swift
//  RxSwiftToDo
//
//  Created by gdml on 18/05/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import Foundation

struct Place: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
