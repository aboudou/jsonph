//
//  Comment.swift
//  jsonph
//
//  Created by Arnaud Boudou on 21/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

// MARK: - Comment
struct Comment {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}

extension Comment {
    init(with json: JSON) {
        self.id = json["id"] as! Int
        self.postId = json["postId"] as! Int
        self.name = json["name"] as! String
        self.email = json["email"] as! String
        self.body = json["body"] as! String
    }
}
