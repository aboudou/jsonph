//
//  UIUtils.swift
//  jsonph
//
//  Created by Arnaud Boudou on 20/08/2019.
//  Copyright © 2019 Arnaud Boudou. All rights reserved.
//

import Foundation
import UIKit

class UIUtils {
    
    class func displayErrorMessage(message: String?, viewController: UIViewController) {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: "Error",
                                                    message: message,
                                                    preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                         style: UIAlertAction.Style.default,
                                         handler: { (result : UIAlertAction) -> Void in
                                            
            })
            
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
