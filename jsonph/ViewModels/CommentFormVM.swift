//
//  CommentFormVM.swift
//  jsonph
//
//  Created by Arnaud Boudou on 21/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

struct CommentFormVM {
    let comment: Comment
}

extension CommentFormVM {
    init(postId: Int,
         name: String,
         email: String,
         body: String) {
        
        self.comment = Comment(id: -999, // Le commentaire va être crée, il n'a pas d'id associé. Un id "jetable" est là pour gérer le non optionnel du modèle
                               postId: postId,
                               name: name,
                               email: email,
                               body: body)
    }
}
