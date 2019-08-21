//
//  CommentCellVM.swift
//  jsonph
//
//  Created by Arnaud Boudou on 21/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

struct CommentCellVM {
    private let comment: Comment
}

extension CommentCellVM {
    init(_ comment: Comment) {
        self.comment = comment
    }
}

extension CommentCellVM {
    var name: String {
        return self.comment.name
    }

    var body: String {
        return self.comment.body
    }
}
