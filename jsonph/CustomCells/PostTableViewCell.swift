//
//  PostTableViewCell.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class PostTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, AddCommentViewControllerDelegate {
    
    // Inspiration pour le fonctionnement d'une UICollectionView dans une UITableViewCell
    //   https://ashfurrow.com/blog/putting-a-uicollectionview-in-a-uitableviewcell-in-swift/
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet private weak var commentsCollectionView: UICollectionView!
    
    private var commentListVM: CommentListVM?
    private var postId: Int!
    
    // MARK:- Misc
    func fetchComments(for postId: Int) {
        self.postId = postId
        Api.shared.post_comments(postId: postId) { comments, error in
            if let comments = comments {
                self.commentListVM = CommentListVM(comments: comments)
                DispatchQueue.main.async {
                    self.commentsCollectionView.reloadData()
                }
            }
        }
    }
    func setCollectionViewDataSourceDelegate() {
        self.commentsCollectionView.delegate = self
        self.commentsCollectionView.dataSource = self
    }
    
    // MARK:- Actions
    @IBAction func addCommentTapped() {
        Session.shared.selectedPostId = self.postId
        
        if let nextViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddCommentViewController") as? UINavigationController, let topController = nextViewController.topViewController as? AddCommentViewController {
            
            topController.delegate = self
            
            ((self.superview as? UITableView)?.delegate as? UIViewController)?.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    
    // MARK:- UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let commentListVM = self.commentListVM {
            return commentListVM.comments.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionViewCell", for: indexPath as IndexPath) as? CommentCollectionViewCell else {
            fatalError("CommentCollectionViewCell not found")
        }
        
        if let commentListVM = self.commentListVM {
            let commentCellVM = CommentCellVM(commentListVM.comments[indexPath.item])
            cell.nameLabel.text = commentCellVM.name
            cell.bodyLabel.text = commentCellVM.body
        }
            
        
        return cell
    }
    
    // MARK:- AddCommentViewControllerDelegate
    func commentSaved(controller: UIViewController, commentFormVM: CommentFormVM) {
        MBProgressHUD.showAdded(to: controller.view, animated: true)
        Api.shared.add_comment(comment: commentFormVM.comment) { comment, error in
            MBProgressHUD.hide(for: controller.view, animated: true)
            if let comment = comment {
                self.commentListVM?.comments.append(comment)
                DispatchQueue.main.async {
                    self.commentsCollectionView.reloadData()
                }
            }
        }
        
        controller.dismiss(animated: true, completion: nil)
    }

}
