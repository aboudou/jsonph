//
//  Post.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

// Note : n'ayant pas trouvé de swagger pour la description des API de JSONPlaceholder,
//   je suis parti du principe que l'ensemble des attributs JSON non sensibles sont optionnels.
//   C'est moins joli à voir, mais c'est moins risqué.

// MARK: - Post
struct Post {
    var id: Int
    var userId: Int
    var title: String
    var body: String?
}

extension Post {
    init(with json: JSON) {
        self.id = json["id"] as! Int
        self.userId = json["userId"] as! Int
        self.title = json["title"] as! String
        self.body = json["body"] as? String
    }
}

