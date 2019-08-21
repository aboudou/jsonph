//
//  PostTests.swift
//  jsonphTests
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

import XCTest
@testable import jsonph

class PostTests: XCTestCase {
    
    var post1: Post!
    var post2: Post!
    var postList = [Post]()
    
    override func setUp() {
        post1 = Post(id: 1,
                     userId: 1,
                     title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                     body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        
        postList.append(post1)
        
        
        
        post2 = Post(id: 2,
                     userId: 1,
                     title: "qui est esse",
                     body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
        
        postList.append(post2)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJSON2Post() {
        let jsonString = """
        [
            {
                "userId": 1,
                "id": 1,
                "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                "body": "quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto"
            },
            {
                "userId": 1,
                "id": 2,
                "title": "qui est esse",
                "body": "est rerum tempore vitae\\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\\nqui aperiam non debitis possimus qui neque nisi nulla"
            }
        ]
        """
        
        do {
            if let json = jsonString.data(using: String.Encoding.utf8) {
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String: Any]] {
                    let posts = jsonData.map({Post(with: $0)})
                    
                    XCTAssert(posts.count == 2, "Posts count should be '2', '\(posts.count)' found")
                    XCTAssert(posts[0].userId == 1, "UserId should be '1', '\(posts[0].userId)' found")
                    XCTAssert(posts[1].title == "qui est esse", "qui est esse', '\(posts[1].title)' found")
                    
                } else {
                    XCTFail("JSON Serialization error")
                }
            } else {
                XCTFail("JSON Serialization error")
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testPostList2PostListVM() {
        let postListVM = PostListVM(posts: self.postList)
        
        XCTAssert(postListVM.posts.count == 2, "Posts count should be '2', '\(postListVM.posts.count)' found")
        XCTAssert(postListVM.posts[0].userId == 1, "UserId should be '1', '\(postListVM.posts[0].userId)' found")
        XCTAssert(postListVM.posts[1].title == "qui est esse", "Title should be 'qui est esse', '\(postListVM.posts[1].title)' found")
    }
    
    func testPost2PostCellVM() {
        let postCellVM = PostCellVM(post1)
        
        XCTAssert(postCellVM.id == 1, "Id should be '1', '\(postCellVM.title)' found")
        XCTAssert(postCellVM.title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", "Title should be 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit', '\(postCellVM.title)' found")
        XCTAssert(postCellVM.body == "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto", "Body should be 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto', '\(postCellVM.body!)' found")
    }
}
