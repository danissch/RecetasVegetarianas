//
//  RefreshControlHandler.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 4/05/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class RefreshControlHandler {
    static let shared = RefreshControlHandler()
    var refreshControl = UIRefreshControl()
    var viewController: UIViewController = UIViewController()
    var actionRefresh: (() -> ())?
    var actionCloseRefresh: (() -> ())?
    var nvActivityIndicator: NVActivityIndicatorView?
    
    func setupRefreshControl(viewController:UIViewController, tableView:UITableView){
        self.viewController = viewController
        refreshControl.autoresizingMask = [.flexibleWidth]
        refreshControl.tintColor = .clear
        refreshControl.attributedTitle = NSAttributedString(string: "Desliza para refrescar")
        refreshControl.backgroundColor = .lightGray
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        
        nvActivityIndicator = NVActivityIndicatorView(
            frame: CGRect(
                x: refreshControl.frame.origin.x,
                y: refreshControl.frame.origin.y,
                width: refreshControl.bounds.width,
                height: refreshControl.bounds.height-20
            ),
            type: NVActivityIndicatorType.ballBeat,
            color: .white,
            padding: 0
        )
        nvActivityIndicator?.backgroundColor = refreshControl.backgroundColor
        nvActivityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addSubview(nvActivityIndicator!)
        
        
        // Add constraint to auto resize nvActivityIndicator as per refresh control view.
        let nvActivityIndicator_top = NSLayoutConstraint(item: nvActivityIndicator!, attribute: .top, relatedBy: .equal, toItem: refreshControl, attribute: .top, multiplier: 1, constant: 0)
        let nvActivityIndicator_bottom = NSLayoutConstraint(item: nvActivityIndicator!, attribute: .bottom, relatedBy: .equal, toItem: refreshControl, attribute: .bottom, multiplier: 1, constant: 0)
        let nvActivityIndicator_leading = NSLayoutConstraint(item: nvActivityIndicator!, attribute: .leading, relatedBy: .equal, toItem: refreshControl, attribute: .leading, multiplier: 1, constant: 0)
        let nvActivityIndicator_trailing = NSLayoutConstraint(item: nvActivityIndicator!, attribute: .trailing, relatedBy: .equal, toItem: refreshControl, attribute: .trailing, multiplier: 1, constant: 0)

        // Add constrains
        refreshControl.addConstraint(nvActivityIndicator_top)
        refreshControl.addConstraint(nvActivityIndicator_bottom)
        refreshControl.addConstraint(nvActivityIndicator_leading)
        refreshControl.addConstraint(nvActivityIndicator_trailing)

        // Set custom view background colour as per refreshControl background colour
        refreshControl.tintColor = refreshControl.backgroundColor
        
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject){
        Connectivity.checkInternetConnection(viewController: viewController, actionOnNoConnection: {
            closeRefresh()
        })
        self.nvActivityIndicator?.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)){
            self.actionRefresh?()
        }
        
    }
    
    func closeRefresh(){
        self.refreshControl.endRefreshing()
        self.actionCloseRefresh?()
    }
    
    
}
