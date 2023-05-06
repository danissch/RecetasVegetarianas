//
//  MediaTableViewCell.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 2/05/23.
//

import Foundation
import UIKit

class MediaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.boxStyle1(cornerRadius: 5)
    }
    
}
