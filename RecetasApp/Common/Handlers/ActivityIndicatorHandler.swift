//
//  ActivityIndicatorHandler.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 4/05/23.
//

import Foundation
import NVActivityIndicatorView

class ActivityIndicatorHandler {
    
    static let shared = ActivityIndicatorHandler()
    
    var loading:NVActivityIndicatorView!
    var coverView: UIView!
    
    func setActivityIndicatorConfig(viewController:UIViewController){
        let view = UIView(frame: viewController.navigationController?.view.frame ?? viewController.view.frame)
        coverView = view
        coverView.backgroundColor = .black
        coverView.alpha = 0.0
        loading = NVActivityIndicatorView(
            frame: coverView.frame,
            type: .circleStrokeSpin,
            color: .systemGray,
            padding: viewController.view.frame.width / 3
        )
        
        coverView.addSubview(loading)
        
        viewController.navigationController?.view.addSubview(coverView)
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .transitionCrossDissolve, animations: {
                
                self.coverView.alpha = 0.8
                
        }, completion: nil)
        
        coverView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loading.autoresizingMask = [
            .flexibleLeftMargin,
            .flexibleTopMargin,
            .flexibleRightMargin,
            .flexibleBottomMargin
        ]
        loading.translatesAutoresizingMaskIntoConstraints = true
    }

    func startActivityIndicator(){
        self.loading.startAnimating()
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: {
            self.coverView?.alpha = 0.8
        })
    }

    func stopActivityIndicator(){
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 1.5){
            UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.coverView?.alpha = 0
            }) { (_) in
                    self.loading.stopAnimating()
            }
        }
    }
    
    
    
}



