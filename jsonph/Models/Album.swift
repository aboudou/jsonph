//
//  Album.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

// MARK: - Album
struct Album {
    var id: Int
    var userId: Int
    var title: String
}

extension Album {
    init(with json: JSON) {
        self.id = json["id"] as! Int
        self.userId = json["userId"] as! Int
        self.title = json["title"] as! String
    }
}

