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
    
    
    var addBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
//     var fetchController : NSFetchedResultsController<PlayerEntity>? = {
//
//         let request = PlayerEntity.createFetchRequest()
//
//         let sort = NSSortDescriptor(key: "name", ascending: false)
//        request.sortDescriptors = [sort]
//
//
//         let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDel
//            .persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        return frc
//    }()
    
    var fetchController:NSFetchedResultsController<PlayerEntity>!
    
    
    
    override func viewDidLoad() {
        
       
        fetchSavedData()
        setupUI()
       
    }
    
    
    func fetchSavedData(){
        
        let request = PlayerEntity.createFetchRequest()
       
                let sort = NSSortDescriptor(key: "name", ascending: false)
               request.sortDescriptors = [sort]

                fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDel.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        
        fetchController.delegate  = self
        
        
        do {
         try   fetchController.performFetch()
            
        }catch{
            
            
        }
    }
    
    
    func setupUI(){
        self.view.addSubview(tableView)
        self.view.addSubview(addBtn)
        
        
        self.tableView.register(FRCTableCell.self, forCellReuseIdentifier: "FRCTableCell")

        tableView.delegate = self
        tableView.dataSource = self
        
//        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10)])
        
        
        self.tableView.frame = CGRect(x: 20, y: 200, width: 250, height: 300)
        self.addBtn.frame = CGRect(x: 100, y: 50, width: 100, height: 50)
        
        addBtn.backgroundColor = UIColor.gray
        
        addBtn.isUserInteractionEnabled = true
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(addDummyRecord))
        
        addBtn.addTarget(self, action: #selector(addDummyRecord), for: .touchUpInside)
    }
    
    
    @objc func addDummyRecord(){
        
        
        
            
        
        
        let managedContext = appDel.persistentContainer.viewContext
        let entity = PlayerEntity(entity:NSEntityDescription.entity(forEntityName: "PlayerEntity", in : managedContext)! , insertInto: managedContext)
        
        entity.name = "Peter"

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
        
        cell.playerNameLbl?.text = fetchController.object(at: indexPath).name
        return cell
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let fc = fetchController else {return 0  }
        return fc.sections?[section].numberOfObjects ?? 0
    }
    
    
}
extension FRCTableVC:NSFetchedResultsControllerDelegate{
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

    // Do not force unwrap
            switch type {

            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .top)
                break
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
                break
            case .update:
                tableView.reloadRows(at: [indexPath!], with: .top)
            case .move:
                tableView.reloadRows(at: [indexPath!], with: .top)
            default:
                fatalError("feature not yet implemented")
            }
        }
}

