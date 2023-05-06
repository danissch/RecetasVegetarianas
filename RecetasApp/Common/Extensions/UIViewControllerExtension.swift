//
//  UIViewControllerExtension.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 2/05/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    internal class func instantiateFromXIB<T:UIViewController>() -> T {
        let xibName = T.stringRepresentation
        let vc = T(nibName: xibName, bundle: nil)
        return vc
    }
    
    
    func pushVc(_ uiViewController: UIViewController,
                animated:Bool = true,
                navigationBarIsHidden:Bool,
                presentStyle:UIModalPresentationStyle = .fullScreen,
                transitionStyle:UIModalTransitionStyle = .coverVertical){
        
        uiViewController.modalPresentationStyle = presentStyle
        
        self.navigationController?.modalPresentationStyle = presentStyle
        self.navigationController?.modalTransitionStyle = transitionStyle
        
        if navigationBarIsHidden {
            self.navigationController?.navigationBar.isHidden = true
            
        } else {
            //self.navigationController?.navigationBar.tintColor = UIColor.darkGray
            //self.navigationController?.navigationBar.isTranslucent = false
            //self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
            //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16)]
        }

        self.navigationController?.pushViewController(uiViewController, animated: animated)

    }
    
    func hideKeyboardWhenTappedAround(keyboardIsEnabled: Bool) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = keyboardIsEnabled
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status and drop into background
        view.endEditing(true)
       }
    
    
    
    @objc func setupActivityIndicator(){
        ActivityIndicatorHandler.shared.setActivityIndicatorConfig(viewController: self)
    }
    
    @objc func startLoading(){
        ActivityIndicatorHandler.shared.startActivityIndicator()
    }
    
    @objc func stopLoading(){
        ActivityIndicatorHandler.shared.stopActivityIndicator()
    }
    
    
    func setupRefreshControl(
        viewController:UIViewController,
        tableView:UITableView, onRefresh:@escaping () -> ()?,
        onCloseRefresh:@escaping ()->()?){
        RefreshControlHandler.shared.setupRefreshControl(viewController: viewController, tableView: tableView)
        RefreshControlHandler.shared.actionRefresh = {
            onRefresh()
        }
        
        RefreshControlHandler.shared.actionCloseRefresh = {
            onCloseRefresh()
        }
    }
    
    
}
