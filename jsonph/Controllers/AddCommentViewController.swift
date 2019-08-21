//
//  AddCommentViewController.swift
//  jsonph
//
//  Created by Arnaud Boudou on 21/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import UIKit
import Eureka

protocol AddCommentViewControllerDelegate {
    func commentSaved(controller: UIViewController, commentFormVM: CommentFormVM)
}

class AddCommentViewController: FormViewController {
    
    var delegate: AddCommentViewControllerDelegate?
    
    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        form +++ Section("Who are you ?")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Your name"
                row.tag = "name"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesAlways
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            <<< TextRow(){ row in
                row.title = "Email"
                row.placeholder = "Your email"
                row.tag = "email"
                row.cell.textField.autocapitalizationType = .none
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesAlways
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            +++ Section("Your comment")
            <<< TextAreaRow(){ row in
                row.title = "Comment"
                row.tag = "body"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesAlways
            }
        
    }
    
    
    // MARK:- Actions
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        let validationErrors = form.validate()
        
        if validationErrors.count > 0 {
            UIUtils.displayErrorMessage(message: "All fields are required", viewController: self)
        } else {
            let values = form.values()
            
            let commentFormVM = CommentFormVM(postId: Session.shared.selectedPostId,
                                              name: values["name"] as! String,
                                              email: values["email"] as! String,
                                              body: values["body"] as! String)
            
            self.delegate?.commentSaved(controller: self, commentFormVM: commentFormVM)
        }
    }
}
