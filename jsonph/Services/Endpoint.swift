//
//  Endpoint.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoint {

    case users
    case user_albums(userId: Int)
    case user_posts(userId: Int)
    case album_photos(albumId: Int)
    case post_comments(postId: Int)
    
    case add_comment(comment: Comment)
    
    // MARK: - Public Properties
    var method: Alamofire.HTTPMethod {
        switch self {
        case .users,
             .user_albums,
             .user_posts,
             .album_photos,
             .post_comments:
            return .get
            
        case .add_comment:
            return .post
        }
    }
    
    // Note : pas d'utilisation des nested resources, elles ne fonctionne plus correctement
    //   au moment de la rédaction du code : https://github.com/typicode/jsonplaceholder/issues/91
    var path: String {
        switch self {
        case .users:
            return "/users"
        
        case .user_albums(_):
            return "/albums"
        
        case .user_posts(_):
            return "/posts"
        
        case .album_photos(_):
            return "/photos"
        
        case .post_comments(_),
             .add_comment(_):
            return "/comments"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .user_albums(let userId),
             .user_posts(let userId):
            return ["userId": userId]

        case .album_photos(let albumId):
            return ["albumId": albumId]

        case .post_comments(let postId):
            return ["postId": postId]
            
        case .add_comment(let comment):
            return ["postId": comment.postId, "name": comment.name, "email": comment.email, "body": comment.body]

        default:
            return nil

        }
    }
}
