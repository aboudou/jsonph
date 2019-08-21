//
//  Session.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    var selectedUserId: Int!
    var selectedPostId: Int!
    
    private init() {}

}
