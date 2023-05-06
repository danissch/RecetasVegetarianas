//
//  ItemListTableViewCell.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 1/05/23.
//

import Foundation
import UIKit
import SDWebImage

class ItemListTableViewCell:UITableViewCell {
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var imagenReceta: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mainStackView: UIStackView!


    var receta:Receta?
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in subviews where view != contentView {
            view.removeFromSuperview()
        }
        setupMainContainer()
    }

    func setCellData(receta:Receta){
        self.receta = receta
        setupNameLabel()
        setupRecetaImage()
    }

    func setupMainContainer(){
        mainStackView.boxStyle2(cornerRadius: 5, height: 1)

    }

    func setupNameLabel(){
        self.nameLabel.text = self.receta?.nombre
        self.nameLabel.numberOfLines = 0
        self.nameLabel.lineBreakMode = .byWordWrapping
    }
    
    func setupRecetaImage(){
        let recetaImageUrl = URL(string: receta?.imagen ?? "")
        self.imagenReceta.sd_setImage(with: recetaImageUrl)
    }

}
