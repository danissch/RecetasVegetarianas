//
//  VCTableViewDelegate.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 1/05/23.
//

import Foundation
import UIKit

extension Main:UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.getRecetasListCount() == 0 ? 1 : viewModel?.getRecetasListCount()) ?? 0
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
           
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
       
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeader
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooter
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ListHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: heightForHeader))
        headerView.setConfigFromViewController(title: "", view: getSearchBarView() ?? UISearchBar())
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 70))
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCell(tableView: tableView, cellForRowAt: indexPath)
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.handleItemAction(indexPath: indexPath, action: { receta in
            self.goTo_RecetaDetailViewController(receta: receta)
        })
    }
    
    private func getCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listCount = viewModel?.getRecetasListCount()
        if listCount == 0  {
           let noRowsCell = tableView.dequeueReusableCell(
            withIdentifier: "NoRecordsFoundTableViewCell",
            for: indexPath
           ) as! NoRecordsFoundTableViewCell
           noRowsCell.messageLabel.text = ""
           return noRowsCell
        }
        
        guard let recetasListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItemListTableViewCell") as? ItemListTableViewCell else {
            return UITableViewCell()
        }
        if let receta = viewModel?.getRecetasList()?[indexPath.row] {
            recetasListTableViewCell.setCellData(receta: receta)
            
        }
        return recetasListTableViewCell
    }

}
