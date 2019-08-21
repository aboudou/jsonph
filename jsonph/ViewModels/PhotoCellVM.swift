//
//  PhotoCellVM.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

struct PhotoCellVM {
    private let photo: Photo
}

extension PhotoCellVM {
    init(_ photo: Photo) {
        self.photo = photo
    }
}

extension PhotoCellVM {
    
    var thumbnailUrl: String {
        return self.photo.thumbnailUrl
    }
}
