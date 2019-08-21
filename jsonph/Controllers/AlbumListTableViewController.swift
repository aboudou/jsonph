//
//  AlbumsListTableViewController.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class AlbumListTableViewController: UITableViewController {
    
    private var albumListVM: AlbumListVM!
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
        
        self.navigationController?.visibleViewController?.title = "Albums"
    }


    // MARK:- Actions
    @objc func refreshData(_ sender: Any) {
        self.loadData()
    }
    
    // MARK:- Misc
    private func loadData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Api.shared.user_albums(userId: Session.shared.selectedUserId) { albums, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.refreshCtrl.endRefreshing()

            if let albums = albums {
                self.albumListVM = AlbumListVM(albums: albums)
                
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
    
    // MARK:- Actions
    @objc func addTapped() {
        print("Tapped")
    }

    // MARK:- UITableViewDelegate & UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumListVM != nil ? self.albumListVM.albums.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else {
            fatalError("AlbumTableViewCell not found")
        }

        let albumCellVM = AlbumCellVM(self.albumListVM.albums[indexPath.row])
        cell.titleLabel.text = albumCellVM.title
        cell.setCollectionViewDataSourceDelegate()
        cell.fetchPhotos(for: albumCellVM.id)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
