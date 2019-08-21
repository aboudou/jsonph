//
//  CommentTests.swift
//  jsonphTests
//
//  Created by Arnaud Boudou on 21/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

import XCTest
@testable import jsonph

class CommentTests: XCTestCase {
    
    var comment1: Comment!
    var comment2: Comment!
    var commentList = [Comment]()
    
    override func setUp() {
        comment1 = Comment(id: 1,
                           postId: 1,
                           name: "id labore ex et quam laborum",
                           email: "Eliseo@gardner.biz",
                           body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
        
        commentList.append(comment1)
        
        
        
        comment2 = Comment(id: 2,
                           postId: 1,
                           name: "quo vero reiciendis velit similique earum",
                           email: "Jayne_Kuhic@sydney.com",
                           body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
        
        commentList.append(comment2)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJSON2Album() {
        let jsonString = """
        [
            {
                "postId": 1,
                "id": 1,
                "name": "id labore ex et quam laborum",
                "email": "Eliseo@gardner.biz",
                "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\\ntempora quo necessitatibus\\ndolor quam autem quasi\\nreiciendis et nam sapiente accusantium"
            },
            {
                "postId": 1,
                "id": 2,
                "name": "quo vero reiciendis velit similique earum",
                "email": "Jayne_Kuhic@sydney.com",
                "body": "est natus enim nihil est dolore omnis voluptatem numquam\\net omnis occaecati quod ullam at\\nvoluptatem error expedita pariatur\\nnihil sint nostrum voluptatem reiciendis et"
            }
        ]
        """
        
        do {
            if let json = jsonString.data(using: String.Encoding.utf8) {
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [[String: Any]] {
                    let comments = jsonData.map({Comment(with: $0)})
                    
                    XCTAssert(comments.count == 2, "Comments count should be '2', '\(comments.count)' found")
                    XCTAssert(comments[0].postId == 1, "PostId should be '1', '\(comments[0].postId)' found")
                    XCTAssert(comments[1].name == "quo vero reiciendis velit similique earum", "Name should be 'quo vero reiciendis velit similique earum', '\(comments[1].name)' found")
                    XCTAssert(comments[1].email == "Jayne_Kuhic@sydney.com", "Email should be 'Jayne_Kuhic@sydney.com', '\(comments[1].email)' found")
                    XCTAssert(comments[1].body == "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et", "Body should be 'est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et', '\(comments[1].body)' found")

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
    
    func testCommentList2CommentListVM() {
        let commentListVM = CommentListVM(comments: self.commentList)
        
        XCTAssert(commentListVM.comments.count == 2, "Comments count should be '2', '\(commentListVM.comments.count)' found")
        XCTAssert(commentListVM.comments[0].postId == 1, "PostId should be '1', '\(commentListVM.comments[0].postId)' found")
        XCTAssert(commentListVM.comments[1].name == "quo vero reiciendis velit similique earum", "Name should be 'quo vero reiciendis velit similique earum', '\(commentListVM.comments[1].name)' found")
        XCTAssert(commentListVM.comments[1].email == "Jayne_Kuhic@sydney.com", "Email should be 'Jayne_Kuhic@sydney.com', '\(commentListVM.comments[1].email)' found")
        XCTAssert(commentListVM.comments[1].body == "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et", "Body should be 'est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et', '\(commentListVM.comments[1].body)' found")
    }
    
    func testComment2CommentCellVM() {
        let commentCellVM = CommentCellVM(comment1)
        
        XCTAssert(commentCellVM.name == "id labore ex et quam laborum", "Name should be 'id labore ex et quam laborum', '\(commentCellVM.name)' found")
        XCTAssert(commentCellVM.body == "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium", "Body should be 'laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium', '\(commentCellVM.body)' found")
    }
    
    func testCommentFormVM2Comment() {
        let commentFormVM = CommentFormVM(postId: 1,
                                          name: "A name",
                                          email: "An email",
                                          body: "A body")
        
        XCTAssert(commentFormVM.comment.id == -999, "Id should be '-999', '\(commentFormVM.comment.id) was found")
        XCTAssert(commentFormVM.comment.postId == 1, "PostId should be '1', '\(commentFormVM.comment.postId) was found")
        XCTAssert(commentFormVM.comment.name == "A name", "Name should be 'A name', '\(commentFormVM.comment.name) was found")
        XCTAssert(commentFormVM.comment.email == "An email", "Email should be 'An email', '\(commentFormVM.comment.email) was found")
        XCTAssert(commentFormVM.comment.body == "A body", "Body should be 'A body', '\(commentFormVM.comment.body) was found")
        
    }
}
