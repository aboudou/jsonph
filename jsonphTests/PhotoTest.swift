//
//  PhotoTest.swift
//  jsonphTests
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

import XCTest
@testable import jsonph

class PhotoTests: XCTestCase {
    
    var photo1: Photo!
    var photo2: Photo!
    var photoList = [Photo]()
    
    override func setUp() {
        
        photo1 = Photo(id: 1,
                       albumId: 1,
                       title: "accusamus beatae ad facilis cum similique qui sunt",
                       url: "https://via.placeholder.com/600/92c952",
                       thumbnailUrl: "https://via.placeholder.com/150/92c952")
        
        photoList.append(photo1)
        
        
        
        photo2 = Photo(id: 2,
                       albumId: 1,
                       title: "reprehenderit est deserunt velit ipsam",
                       url: "https://via.placeholder.com/600/771796",
                       thumbnailUrl: "https://via.placeholder.com/150/771796")
        
        photoList.append(photo2)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJSON2Album() {
        let jsonString = """
        [
            {
                "albumId": 1,
                "id": 1,
                "title": "accusamus beatae ad facilis cum similique qui sunt",
                "url": "https://via.placeholder.com/600/92c952",
                "thumbnailUrl": "https://via.placeholder.com/150/92c952"
            },
            {
                "albumId": 1,
                "id": 2,
                "title": "reprehenderit est deserunt velit ipsam",
                "url": "https://via.placeholder.com/600/771796",
                "thumbnailUrl": "https://via.placeholder.com/150/771796"
            }
        ]
        """
        
        do {
            if let json = jsonString.data(using: String.Encoding.utf8) {
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String: Any]] {
                    let photos = jsonData.map({Photo(with: $0)})
                    
                    XCTAssert(photos.count == 2, "Photos count should be '2', '\(photos.count)' found")
                    XCTAssert(photos[0].albumId == 1, "AlbumId should be '1', '\(photos[0].albumId)' found")
                    XCTAssert(photos[1].title == "reprehenderit est deserunt velit ipsam", "Title should be 'reprehenderit est deserunt velit ipsam', '\(photos[1].title!)' found")
                    XCTAssert(photos[1].url == "https://via.placeholder.com/600/771796", "Url should be 'https://via.placeholder.com/600/771796', '\(photos[1].url)' found")
                    XCTAssert(photos[1].thumbnailUrl == "https://via.placeholder.com/150/771796", "ThumbnailUrl should be 'https://via.placeholder.com/150/771796', '\(photos[1].thumbnailUrl)' found")

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
    
    func testPhotoList2PhotoListVM() {
        let photoListVM = PhotoListVM(photos: self.photoList)
        
        XCTAssert(photoListVM.photos.count == 2, "Photos count should be '2', '\(photoListVM.photos.count)' found")
        XCTAssert(photoListVM.photos[0].albumId == 1, "UserId should be '1', '\(photoListVM.photos[0].albumId)' found")
        XCTAssert(photoListVM.photos[1].title == "reprehenderit est deserunt velit ipsam", "Title should be 'reprehenderit est deserunt velit ipsam', '\(photoListVM.photos[1].title!)' found")
        XCTAssert(photoListVM.photos[1].url == "https://via.placeholder.com/600/771796", "Url should be 'https://via.placeholder.com/600/771796', '\(photoListVM.photos[1].url)' found")
        XCTAssert(photoListVM.photos[1].thumbnailUrl == "https://via.placeholder.com/150/771796", "ThumbnailUrl should be 'https://via.placeholder.com/150/771796', '\(photoListVM.photos[1].thumbnailUrl)' found")
    }
    
    func testPhoto2PhotoCellVM() {
        let photoCellVM = PhotoCellVM(photo1)
        
        XCTAssert(photoCellVM.thumbnailUrl == "https://via.placeholder.com/150/92c952", "ThumbnailUrl should be 'https://via.placeholder.com/150/92c952', '\(photoCellVM.thumbnailUrl)' found")
    }
}
