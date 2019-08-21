//
//  Api.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation

class Api {
    
    static let shared = Api()

    let baseURL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    private init() {}
    
    /// Retourne la liste des users
    ///
    /// - Parameter completion: Liste des utilisateurs ou une erreur
    func users(completion: @escaping ([User]?, ApiError?)->()) {
        let endpoint = Endpoint.users
        
        AlamofireHelper.request(baseUrl: self.baseURL, endpoint: endpoint).responseJSON { (response) in
            switch response.response?.statusCode {
            case 200?:
                switch response.result {
                case .success(let jsonList):
                    if let jsonList = jsonList as? JSONList {
                        let users = jsonList.map({User(with: $0)})
                        
                        completion(users, nil)
                    } else {
                        completion(nil, ApiError.invalidJson)
                    }
                default:
                    completion(nil, ApiError.otherError)
                }
            default:
                let error = response.error
                print("error: \(String(describing: error))")
                completion(nil, ApiError.otherError)
            }
        }
    }


    /// Retourne la liste des albums d'un user
    ///
    /// - Parameter completion: Liste des albums d'un user ou une erreur
    func user_albums(userId: Int, completion: @escaping ([Album]?, ApiError?)->()) {
        let endpoint = Endpoint.user_albums(userId: userId)
        
        AlamofireHelper.request(baseUrl: self.baseURL, endpoint: endpoint).responseJSON { (response) in
            switch response.response?.statusCode {
            case 200?:
                switch response.result {
                case .success(let jsonList):
                    if let jsonList = jsonList as? JSONList {
                        let albums = jsonList.map({Album(with: $0)})
                        
                        completion(albums, nil)
                    } else {
                        completion(nil, ApiError.invalidJson)
                    }
                default:
                    completion(nil, ApiError.otherError)
                }
            default:
                let error = response.error
                print("error: \(String(describing: error))")
                completion(nil, ApiError.otherError)
            }
        }
    }

    
    /// Retourne la liste des posts d'un user
    ///
    /// - Parameter completion: Liste des posts d'un user ou une erreur
    func user_posts(userId: Int, completion: @escaping ([Post]?, ApiError?)->()) {
        let endpoint = Endpoint.user_posts(userId: userId)
        
        AlamofireHelper.request(baseUrl: self.baseURL, endpoint: endpoint).responseJSON { (response) in
            switch response.response?.statusCode {
            case 200?:
                switch response.result {
                case .success(let jsonList):
                    if let jsonList = jsonList as? JSONList {
                        let posts = jsonList.map({Post(with: $0)})
                        
                        completion(posts, nil)
                    } else {
                        completion(nil, ApiError.invalidJson)
                    }
                default:
                    completion(nil, ApiError.otherError)
                }
            default:
                let error = response.error
                print("error: \(String(describing: error))")
                completion(nil, ApiError.otherError)
            }
        }
    }


    /// Retourne la liste des photos d'un album
    ///
    /// - Parameter completion: Liste des photos d'un album ou une erreur
    func album_photos(albumId: Int, completion: @escaping ([Photo]?, ApiError?)->()) {
        let endpoint = Endpoint.album_photos(albumId: albumId)
        
        AlamofireHelper.request(baseUrl: self.baseURL, endpoint: endpoint).responseJSON { (response) in
            switch response.response?.statusCode {
            case 200?:
                switch response.result {
                case .success(let jsonList):
                    if let jsonList = jsonList as? JSONList {
                        let photos = jsonList.map({Photo(with: $0)})
                        
                        completion(photos, nil)
                    } else {
                        completion(nil, ApiError.invalidJson)
                    }
                default:
                    completion(nil, ApiError.otherError)
                }
            default:
                let error = response.error
                print("error: \(String(describing: error))")
                completion(nil, ApiError.otherError)
            }
        }
    }


    /// Retourne la liste des commentaires d'un post
    ///
    /// - Parameter completion: Liste des commentaires d'un post ou une erreur
    func post_comments(postId: Int, completion: @escaping ([Comment]?, ApiError?)->()) {
        let endpoint = Endpoint.post_comments(postId: postId)
        
        AlamofireHelper.request(baseUrl: self.baseURL, endpoint: endpoint).responseJSON { (response) in
            switch response.response?.statusCode {
            case 200?:
                switch response.result {
                case .success(let jsonList):
                    if let jsonList = jsonList as? JSONList {
                        let comments = jsonList.map({Comment(with: $0)})
                        
                        completion(comments, nil)
                    } else {
                        completion(nil, ApiError.invalidJson)
                    }
                default:
                    completion(nil, ApiError.otherError)
                }
            default:
                let error = response.error
                print("error: \(String(describing: error))")
                completion(nil, ApiError.otherError)
            }
        }
    }


    /// Soumet un commentaire
    ///
    /// - Parameters:
    ///   - comment: le commentaire à soumettre
    ///   - completion: Le commentaire soumis ou une erreur
    func add_comment(comment: Comment, completion: @escaping (Comment?, ApiError?)->()) {
        let endpoint = Endpoint.add_comment(comment: comment)
        
        AlamofireHelper.request(baseUrl: self.baseURL, endpoint: endpoint).responseJSON { (response) in
            switch response.response?.statusCode {
            case 201?:
                switch response.result {
                case .success(let json):
                    if let json = json as? JSON {
                        let comment = Comment(with: json)
                        
                        completion(comment, nil)
                    } else {
                        completion(nil, ApiError.invalidJson)
                    }
                default:
                    completion(nil, ApiError.otherError)
                }
            default:
                let error = response.error
                print("error: \(String(describing: error))")
                completion(nil, ApiError.otherError)
            }
        }
    }
}
