//
//  UIViewController+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

// MARK: - UIViewController elements dimensions
extension UIViewController {
    
    /// Status bar height
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// Navigation bar height
    var navigationBarHeight: CGFloat {
        return (navigationController?.navigationBar.frame ?? .zero).height
    }
    
}

// MARK: - UIViewController extension used for easier presenting alert messages
extension UIViewController {
    
    // MARK: Internal types
    
    /// Alert action struct
    struct AlertAction {
        
        /// Action title
        var title: String
        
        /// Action style
        var style: UIAlertAction.Style
        
        /// Action method
        var action: voidMethod
        
        
        /// Calculated property whish returns UIAlertAction instance
        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: style, handler: { _ in
                self.action()
            })
        }
        
        /// Constructor which initializes new instance using DBParty elemenet fetched from the CoreData
        ///
        /// - Parameters:
        ///   - title: Alert title
        ///   - style: Alert style
        ///   - action: Alert action
        init(title: String = "OK", style: UIAlertAction.Style = .default, action: @escaping voidMethod = { }) {
            self.title = title
            self.style = style
            self.action = action
        }
    }
    
    
    /// Show simple alert
    ///
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Alert message
    func showAlert(title: String, message: String) {
        showComplexAlert(title: title, message: message)
    }
    
    
    /// Show complex alert message
    ///
    /// - Parameters:
    ///   - alertStyle: Alert style
    ///   - title: Alert title
    ///   - message: Alert message
    ///   - actions: Alert actions
    func showComplexAlert(alertStyle: UIAlertController.Style = .alert, title: String? = nil, message: String? = nil, actions: [AlertAction] = [AlertAction(title: AppStrings.ok.localized)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        actions.forEach {
            alertController.addAction($0.alertAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
}
