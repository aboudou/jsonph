//
//  UserCellVM.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

struct UserCellVM {
    private let user: User
}

extension UserCellVM {
    init(_ user: User) {
        self.user = user
    }
}

extension UserCellVM {
    
    var name: String? {
        return self.user.name
    }

    var username: String? {
        guard let username = self.user.username else {
            return ""
        }
        return "@\(username)"
    }
}


