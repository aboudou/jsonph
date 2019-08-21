//
//  UserListTableViewController.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class UserListTableViewController: UITableViewController {
    
    private var userListVM: UserListVM!
    private var refreshCtrl = UIRefreshControl()

    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.refreshControl = self.refreshCtrl
        self.refreshCtrl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        self.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let user = self.userListVM.users[indexPath.row]
            
            Session.shared.selectedUserId = user.id
        }
    }
    
    // MARK:- Actions
    @objc func refreshData(_ sender: Any) {
        self.loadData()
    }
    
    // MARK:- Misc
    private func loadData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Api.shared.users { users, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.refreshCtrl.endRefreshing()

            if let users = users {
                self.userListVM = UserListVM(users: users)
                
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
        return self.userListVM != nil ? self.userListVM.users.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            fatalError("UserTableViewCell not found")
        }
    
        let userCellVM = UserCellVM(self.userListVM.users[indexPath.row])
        cell.nameLabel.text = userCellVM.name
        cell.usernameLabel.text = userCellVM.username
        
        return cell
    }
}
