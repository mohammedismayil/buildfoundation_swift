//
//  FRCTable.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 15/01/23.
//

import Foundation

import UIKit

import CoreData
class FRCTableVC:UIViewController{
    
    
    
    let tableView:UITableView = {
        
        let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    
     var fetchController : NSFetchedResultsController<PlayerEntity>? = {
        
         let request = PlayerEntity.createFetchRequest()
                
         let sort = NSSortDescriptor(key: "name", ascending: false)
        request.sortDescriptors = [sort]
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
         let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDelegate
            .persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }()
    
    
    
    override func viewDidLoad() {
        addDummyRecord()
        setupUI()
       
    }
    
    
    func setupUI(){
        self.view.addSubview(tableView)
        
        
        self.tableView.register(FRCTableCell.self, forCellReuseIdentifier: "FRCTableCell")

        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10)])
    }
    
    
    func addDummyRecord(){
        
        
        
            
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
                //2
                let entity = PlayerEntity(entity:NSEntityDescription.entity(forEntityName: "PlayerEntity", in : managedContext)! , insertInto: managedContext)
                   
        
        entity.name = "Laxman"
                //4
        do {
            try managedContext.save()
            
            
            
        }catch {
            
        }
        
        
    }
}


extension FRCTableVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FRCTableCell", for: indexPath) as! FRCTableCell
        
        cell.playerNameLbl?.text = "Laxman"
        return cell
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let fc = fetchController else {return 0  }
        return fc.sections?[section].numberOfObjects ?? 0
    }
    
    
}
