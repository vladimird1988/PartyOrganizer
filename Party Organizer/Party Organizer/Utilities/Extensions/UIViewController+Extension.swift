//
//  UIViewController+Extension.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - UIViewController elements dimensions
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var navigationBarHeight: CGFloat {
        return (navigationController?.navigationBar.frame ?? .zero).height
    }
    
    
    // MARK: - Alert messages
    
    struct AlertAction {
        var title: String
        var style: UIAlertAction.Style
        var action: voidMethod
        
        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: style, handler: { _ in
                self.action()
            })
        }
        
        init(title: String = "OK", style: UIAlertAction.Style = .default, action: @escaping voidMethod = { }) {
            self.title = title
            self.style = style
            self.action = action
        }
    }
    
    func showAlert(title: String, message: String) {
        showComplexAlert(title: title, message: message)
    }
    
    func showComplexAlert(alertStyle: UIAlertController.Style = .alert, title: String? = nil, message: String? = nil, actions: [AlertAction] = [AlertAction(title: AppStrings.ok.localized)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        actions.forEach {
            alertController.addAction($0.alertAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
}
