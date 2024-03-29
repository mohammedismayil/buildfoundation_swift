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
     var matchLocationLabel:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "FRCTableCell")
        
        
        setupUI()
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI(){
        
        
        playerNameLbl = UILabel()
        matchLocationLabel = UILabel()
        contentView.addSubview(playerNameLbl)
        contentView.addSubview(matchLocationLabel)
        playerNameLbl.numberOfLines = 0
        matchLocationLabel.numberOfLines = 0
        playerNameLbl.sizeToFit()
        matchLocationLabel.sizeToFit()
        playerNameLbl.translatesAutoresizingMaskIntoConstraints = false
        matchLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([playerNameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),playerNameLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),playerNameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),playerNameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50)])
        NSLayoutConstraint.activate([matchLocationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),matchLocationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)])
        
        
    }
    
}
