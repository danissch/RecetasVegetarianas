//
//  ButtonMapTableViewCell.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 3/05/23.
//

import Foundation
import UIKit

class ButtonMapTableViewCell:UITableViewCell {
    
    
    @IBOutlet weak var buttonContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonContainer.boxStyle1(cornerRadius: 4)
    }
    

    
}
