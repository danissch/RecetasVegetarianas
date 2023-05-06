//
//  VCSearchBarDelegate.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 1/05/23.
//

import Foundation
import UIKit

extension Main: UISearchBarDelegate {
    func getSearchBarView() -> CustomSearchBar? {
        customSearchBar = CustomSearchBar()
        customSearchBar = customSearchBar?.getSearchBar(delegate: self as UISearchBarDelegate) as? CustomSearchBar
        customSearchBar?.searchTextField.delegate = self
        customSearchBar?.resignFirstResponder()
        return customSearchBar
    }
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isEditing = true
        searchTextFieldValue = ""
        searchTextFieldIsFirstResponder = true
        hideKeyboardWhenTappedAround(keyboardIsEnabled: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isEditing = false
        if searchTextFieldIsFirstResponder {
            searchTextFieldValue = searchBar.searchTextField.text ?? ""
            searchTextFieldIsFirstResponder = false
        }
        hideKeyboardWhenTappedAround(keyboardIsEnabled: false)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isEditing = false
        searchBar.text = ""
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isEditing = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.searchTextField.text
        if searchBar.text == "" {
            viewModel?.isSearching = false
            if self.viewModel?.filteredRecetasCount() == 0 {
                self.customSearchBar?.setNoResultsMessageSearch(viewController: self)
                customSearchBar?.text = ""
            }
            self.getData()
            
        } else {
            viewModel?.isSearching = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.viewModel?.filteredRecetas.removeAll(keepingCapacity: false)
                self.viewModel?.filteredRecetas = self.defineNewList(searchBar: searchBar)
                self.viewModel?.isSearching = (self.viewModel?.filteredRecetasCount() == 0) ? false: true
                self.tableView.reloadData()
            })
        }
    }
    
    
    
    func defineNewList(searchBar:UISearchBar) -> [Receta]{
        guard let predicateString = searchBar.text?.lowercased() else { return [] }
        guard let newList = self.viewModel?.recetas.filter({($0.nombre.lowercased().range(of: predicateString) != nil) || ($0.ingredientes.lowercased().range(of: predicateString) != nil)}) else { return []}
        return newList
    }
        
    func fixOrientationBehaviors(){
        guard let searchTextFieldIsFirstResponder = customSearchBar?.searchTextField.isFirstResponder else { return }
        self.searchTextFieldIsFirstResponder = searchTextFieldIsFirstResponder
        self.customSearchBar?.searchTextField.resignFirstResponder()
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            if searchTextFieldIsFirstResponder {
                self.customSearchBar?.searchTextField.text = self.searchTextFieldValue
                self.customSearchBar?.searchTextField.becomeFirstResponder()
            }
            
        })
    }
}

extension Main:UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
}
