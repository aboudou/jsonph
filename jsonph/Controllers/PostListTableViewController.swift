//
//  PostListTableViewController.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class PostListTableViewController: UITableViewController {
    
    private var postListVM: PostListVM!
    private var refreshCtrl = UIRefreshControl()

    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.refreshControl = self.refreshCtrl
        self.refreshCtrl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.visibleViewController?.title = "Posts"
    }
    
    // MARK:- Actions
    @objc func refreshData(_ sender: Any) {
        self.loadData()
    }
    
    // MARK:- Misc
    private func loadData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Api.shared.user_posts(userId: Session.shared.selectedUserId) { posts, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.refreshCtrl.endRefreshing()
            
            if let posts = posts {
                self.postListVM = PostListVM(posts: posts)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } else {
                if let apiError = error {
                    UIUtils.displayErrorMessage(message: apiError.rawValue, viewController: self)
                }
            }
        }
    }
    
    // MARK:- UITableViewDelegate & UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postListVM != nil ? self.postListVM.posts.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            fatalError("PostTableViewCell not found")
        }

        let postCellVM = PostCellVM(self.postListVM.posts[indexPath.row])
        cell.titleLabel.text = postCellVM.title
        cell.bodyLabel.text = postCellVM.body

        cell.setCollectionViewDataSourceDelegate()
        cell.fetchComments(for: postCellVM.id)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
