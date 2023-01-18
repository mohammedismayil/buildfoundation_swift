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
    
    
    var addBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
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
        
//        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(addBtn)
        self.view.addSubview(tableView)
        
        
        
        self.tableView.register(FRCTableCell.self, forCellReuseIdentifier: "FRCTableCell")

        tableView.delegate = self
        tableView.dataSource = self
        
//        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10)])
        
        
        self.tableView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150)
        self.addBtn.frame = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100, width: 100, height: 40)
        
      
        addBtn.addTarget(self, action: #selector(moveToPlayerAddVC), for: .touchUpInside)
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
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("Trait changed")
    }
    
    
    @objc func moveToPlayerAddVC(){
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = main.instantiateViewController(withIdentifier: "FRCPlayerAddVC") as! FRCPlayerAddVC
        
        self.navigationController?.present(vc, animated: true)
        
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
