//
//  PlayerEntityListVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 21/03/23.
//


import Foundation

import UIKit

import CoreData
class PlayerEntityListVC:UIViewController{
    
    
    
    let tableView:UITableView = {
        
        let tbl = UITableView(frame: .zero, style: .grouped)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
    
    var addBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var nextButton:ThemeAddButton = {
        let btn = ThemeAddButton()
        btn.setTitle("Next", for: .normal)
//        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var coreDataHandler:CoreDataManager!

    
    override func viewDidLoad() {
        
        initNotificationObserver()
        fetchSavedData()
        setupUI()
       
    }
    
    
    func fetchSavedData(){
        
        coreDataHandler = CoreDataManager.shared
        
        coreDataHandler.fetchPlayersData()
        
        coreDataHandler?.playerFetchController.delegate = self
        
    }
    
    func initNotificationObserver(){
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(addPlayer), name: Notification.Name("AddDummyPlayers"), object: nil)
       
    }
    func setupUI(){
        
//        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        self.view.addSubview(addBtn)
        self.view.addSubview(nextButton)
        self.view.addSubview(tableView)
        
        
        
        self.tableView.register(FRCTableCell.self, forCellReuseIdentifier: "FRCTableCell")

        tableView.delegate = self
        tableView.dataSource = self
        
//        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40)])
        
        
        self.tableView.frame = CGRect(x: 0
                                      , y: view.safeAreaInsets.top + 20, width: UIScreen.main.bounds.width, height: 300)
        self.addBtn.frame = CGRect(x:( UIScreen.main.bounds.width / 2) - 100 - 12.5, y: UIScreen.main.bounds.height - 100, width: 100, height: 40)
        self.nextButton.frame = CGRect(x: self.addBtn.frame.maxX + 25, y: UIScreen.main.bounds.height - 100, width: 100, height: 40)
        
      
        addBtn.addTarget(self, action: #selector(moveToPlayerAddVC), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(moveToNextFRCVC), for: .touchUpInside)
        tableView.layoutIfNeeded()
        tableView.setNeedsLayout()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        
        
        print("Table view contentSize : \(self.tableView.contentSize.height)")
        
//        self.tableView.frame = CGRect(x: 0
//                                      , y: view.safeAreaInsets.top + 20, width: UIScreen.main.bounds.width, height: self.tableView.contentSize.height
//        )
    }
    
    
   
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("Trait changed")
    }
    
    
    @objc func moveToPlayerAddVC(){
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = main.instantiateViewController(withIdentifier: "MatchEntityListVC") as! MatchEntityListVC
        
        self.navigationController?.present(vc, animated: true)
        
    }
    
    @objc func moveToNextFRCVC(){
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = main.instantiateViewController(withIdentifier: "MatchEntityListVC") as! MatchEntityListVC
        
        self.navigationController?.present(vc, animated: true)
        
    }
    
    func checkBaselineOffSet(indexPath:IndexPath)->FRCTableCell{
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FRCTableCell", for: indexPath) as! FRCTableCell
        
        var attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "Lorem ipsum dolor "))
//        attributedText.addAttributes([NSAttributedString.Key.baselineOffset:4], range: NSRange(location: 0, length: 4))
//
        attributedText.addAttributes([NSAttributedString.Key.baselineOffset:20], range: NSRange(location: 0, length: 5))
//        attributedText.addAttributes([NSAttributedString.Key.baselineOffset:5], range: NSRange(location: 6, length: 5))
//        attributedText.addAttributes([NSAttributedString.Key.baselineOffset:7], range: NSRange(location: 11, length: 5))
//        attributedText.addAttributes([NSAttributedString.Key.baselineOffset:9], range: NSRange(location: 16, length: 5))
//
//        attributedText.addAttributes([NSAttributedString.Key.baselineOffset:-3], range: NSRange(location: 21, length: 5))
        cell.playerNameLbl.textAlignment =  .center
        cell.playerNameLbl.attributedText = attributedText
//        cell.playerNameLbl?.text = CoreDataManager.shared.playerFetchController.object(at: indexPath).name
        return cell
    }
}


extension PlayerEntityListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FRCTableCell", for: indexPath) as! FRCTableCell

        cell.playerNameLbl?.text = CoreDataManager.shared.playerFetchController.object(at: indexPath).playerID.description
        return cell
        
//        checkBaselineOffSet(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let fc = CoreDataManager.shared.playerFetchController else {return 0  }
        return fc.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//       return  UITableView.automaticDimension
        
        return 80
        
    }
    
}
extension PlayerEntityListVC:NSFetchedResultsControllerDelegate{
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        print("Player FRC updated in FRCTableVC")
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

extension PlayerEntityListVC:DummyPlayerAddition{
    
    @objc func addPlayer() {
        
        print("Notification addplayers observed in FRCTableVC")
        self.coreDataHandler.addDummyPlayerData()
    }
}
