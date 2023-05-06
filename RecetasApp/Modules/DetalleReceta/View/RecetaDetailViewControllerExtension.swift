//
//  RecetaDetailTableViewDataSource.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 2/05/23.
//

import Foundation
import UIKit

extension RecetaDetailViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.handleGoToAction(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell = getMediaCell(indexPath: indexPath)
           
        case 1:
            cell = getContentCell(contentType: .descripcion, indexPath: indexPath)
        
        case 2:
            cell = getContentCell(contentType: .ingredientes, indexPath: indexPath)
        
        case 3:
            cell = getContentCell(contentType: .preparacion, indexPath: indexPath)
        
        case 4:
            cell = getButtonMapCell()
    
        default: break
        }

        return cell
    }

}

extension RecetaDetailViewController {
    func getMediaCell(indexPath:IndexPath) -> MediaTableViewCell {
        let mediaCell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
        let url = viewModel?.getMediaURL()
        mediaCell.detailedImage.sd_setImage(with: url)
        return mediaCell
    }
    
    func getContentCell(contentType:RecetaContentType, indexPath:IndexPath) -> ContentTableViewCell{
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell
        let content = viewModel?.getContent(contentType: contentType)
        contentCell.item_title.text = content?.title
        if contentType != .descripcion {
            contentCell.item_title.font = UIFont.boldSystemFont(ofSize: 14)
        }
        contentCell.item_text.text = content?.text
        return contentCell
    }
    
    func getButtonMapCell() -> ButtonMapTableViewCell{
        let buttonMapCell = tableView.dequeueReusableCell(withIdentifier: "ButtonMapTableViewCell") as! ButtonMapTableViewCell
        return buttonMapCell
    }
    
}
