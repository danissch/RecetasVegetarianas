//
//  Main.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 1/05/23.
//

import Foundation
import UIKit

extension Main {
        
    func setup(){
        viewModel = MainViewModel()
        setupViews()
        setupActivityIndicator()
        
        self.hideKeyboardWhenTappedAround(keyboardIsEnabled: false)
        setupRefreshControl(viewController: self, tableView: tableView, onRefresh: {
            self.viewModel?.isSearching = false
            self.getData()
        }, onCloseRefresh: {
            self.stopAll()
        })
        
        getData()
    }
    
    private func setupViews(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let headernib = UINib(nibName: "ListHeaderView", bundle: nil)
        tableView.register(headernib, forHeaderFooterViewReuseIdentifier: "listHeaderView")
        
        tableView.register(
            UINib(nibName: "ItemListTableViewCell",bundle: nil),
            forCellReuseIdentifier: "ItemListTableViewCell"
        )
        tableView.register(
            UINib(nibName:"NoRecordsFoundTableViewCell", bundle: nil),
            forCellReuseIdentifier: "NoRecordsFoundTableViewCell"
        )
                
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = heightForCells
        
    }
    
    func getData(){
        startLoading()
        viewModel?.obtenerRecetas { _ in
            
            self.stopAll()
            RefreshControlHandler.shared.closeRefresh()
        }
    }
    
    func stopAll(){
        self.tableView.reloadData()
        self.stopLoading()
    }
    
}
