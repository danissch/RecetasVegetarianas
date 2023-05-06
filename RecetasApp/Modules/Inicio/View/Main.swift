//
//  Main.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 29/04/23.
//

import UIKit
import NVActivityIndicatorView

class Main: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel?
    
    let heightForCells:CGFloat = 320
    let heightForHeader:CGFloat = 60
    let heightForFooter:CGFloat = 30
    
    var customSearchBar:CustomSearchBar?
    
    var searchTextFieldValue: String = ""
    var searchTextFieldIsFirstResponder: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.layoutSubviews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        fixOrientationBehaviors()
    }
}

