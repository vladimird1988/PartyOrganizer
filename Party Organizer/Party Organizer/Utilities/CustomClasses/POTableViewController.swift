//
//  POTableViewController.swift
//  Party Organizer
//
//  Created by Vladimir Dinic on 2/16/19.
//  Copyright © 2019 Vladimir Dinic. All rights reserved.
//

import UIKit
import Device


/// Custom UITableViewController subclass used for setting content inset for different devices, since on some devices (tested on simulator) the navigationBar covers the top of the tableView, so we have to fix it. I suppose that it is a XCode bug, or maybe it works well on a real device
class POTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Device.version() {
        case .iPhone5, .iPhone5C, .iPhone5S, .iPhone6, .iPhone6S:    // For these devices we have to fix the contentInset for the tableView
            tableView.contentInset = UIEdgeInsets(top: navigationBarHeight + statusBarHeight ,left: 0,bottom: 0,right: 0)
        default:
            break
        }
        
    }

}
