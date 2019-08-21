//
//  AlbumCellVM.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

struct AlbumCellVM {
    private let album: Album
}

extension AlbumCellVM {
    init(_ album: Album) {
        self.album = album
    }
}

extension AlbumCellVM {
    
    var id: Int {
        return self.album.id
    }
    
    var title: String {
        return self.album.title
    }
}
