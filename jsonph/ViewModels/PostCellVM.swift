//
//  PostCellVM.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

struct PostCellVM {
    private let post: Post
}

extension PostCellVM {
    init(_ post: Post) {
        self.post = post
    }
}

extension PostCellVM {
    var id: Int {
        return self.post.id
    }
    
    var title: String {
        return self.post.title
    }
    
    var body: String? {
        return self.post.body
    }
}
