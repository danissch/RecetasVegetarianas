//
//  RecetaDetailViewController.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 2/05/23.
//

import Foundation
import UIKit

class RecetaDetailViewController:UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var item:Receta?
    var heightForMedia:CGFloat = 160.0
    var heightForContent:CGFloat = 500.0
    var estimatedHeightRowForContent:CGFloat = 60
    let cellReuseIdentifier = "cell"
    var viewModel: RecetaDetailViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RecetaDetailViewModel(receta: item, viewController: self)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        self.tableView.register(UINib(nibName: "ButtonMapTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonMapTableViewCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension

    }
    
    
}

