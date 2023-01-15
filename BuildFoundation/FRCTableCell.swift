//
//  FRCTableCell.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 15/01/23.
//

import Foundation
import UIKit


class FRCTableCell:UITableViewCell{
    
     var playerNameLbl:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "FRCTableCell")
        
        
        setupUI()
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI(){
        
        
        playerNameLbl = UILabel()
        contentView.addSubview(playerNameLbl)
        playerNameLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([playerNameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20)])
    }
    
}
