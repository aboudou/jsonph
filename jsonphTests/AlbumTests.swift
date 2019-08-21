//
//  AlbumTests.swift
//  jsonphTests
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

import XCTest
@testable import jsonph

class AlbumTests: XCTestCase {

    var album1: Album!
    var album2: Album!
    var albumList = [Album]()
    
    override func setUp() {
        album1 = Album(id: 1,
                       userId: 1,
                       title: "quidem molestiae enim")
        
        albumList.append(album1)
        
        
        
        album2 = Album(id: 2,
                       userId: 1,
                       title: "sunt qui excepturi placeat culpa")
        
        albumList.append(album2)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJSON2Album() {
        let jsonString = """
        [
            {
                "userId": 1,
                "id": 1,
                "title": "quidem molestiae enim"
            },
            {
                "userId": 1,
                "id": 2,
                "title": "sunt qui excepturi placeat culpa"
            }
        ]
        """
        
        do {
            if let json = jsonString.data(using: String.Encoding.utf8) {
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String: Any]] {
                    let albums = jsonData.map({Album(with: $0)})
                    
                    XCTAssert(albums.count == 2, "Albums count should be '2', '\(albums.count)' found")
                    XCTAssert(albums[0].userId == 1, "UserId should be '1', '\(albums[0].userId)' found")
                    XCTAssert(albums[1].title == "sunt qui excepturi placeat culpa", "Title should be 'sunt qui excepturi placeat culpa', '\(albums[1].title)' found")
                    
                } else {
                    XCTFail("JSON Serialization error")
                }
            } else {
                XCTFail("JSON Serialization error")
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func testAlbumList2AlbumListVM() {
        let albumListVM = AlbumListVM(albums: self.albumList)
        
        XCTAssert(albumListVM.albums.count == 2, "Albums count should be '2', '\(albumListVM.albums.count)' found")
        XCTAssert(albumListVM.albums[0].userId == 1, "UserId should be '1', '\(albumListVM.albums[0].userId)' found")
        XCTAssert(albumListVM.albums[1].title == "sunt qui excepturi placeat culpa", "Title should be 'sunt qui excepturi placeat culpa', '\(albumListVM.albums[1].title)' found")
    }
    
    func testAlbum2AlbumCellVM() {
        let albumCellVM = AlbumCellVM(album1)
        
        XCTAssert(albumCellVM.title == "quidem molestiae enim", "Title should be 'quidem molestiae enim', '\(albumCellVM.title)' found")
    }
}
