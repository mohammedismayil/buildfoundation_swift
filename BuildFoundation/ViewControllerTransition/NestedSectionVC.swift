//
//  NestedSectionVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 01/05/23.
//

import Foundation
import UIKit



struct Section {
    var title:String
    var subSection:[SubSection]
}
struct SubSection {
    var title:String
    var row:[Row]
}
struct Row {
    var title:String
}
class NestedSectionVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sections:[Section] = [Section(title: "Sports", subSection: [SubSection(title: "Bat-and-ball", row: [Row(title: "Baseball"),Row(title: "Softball"),Row(title: "Cricket")])]),
                              Section(title: "Engineering", subSection: [SubSection(title: "Science", row: [Row(title: "Baseball"),Row(title: "Softball"),Row(title: "Cricket")])])]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        
    }
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NestedSectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].subSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NestedTableViewCell", for: indexPath) as! NestedTableViewCell
        cell.titleLabel.text = "T"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
        sectionView.backgroundColor = UIColor.magenta

        let sectionName = UILabel(frame: CGRect(x: 5, y: 0, width: tableView.frame.size.width, height: 25))
        sectionName.text = sections[section].title
        sectionName.textColor = UIColor.white
        sectionName.font = UIFont.systemFont(ofSize: 14)
        sectionName.textAlignment = .left

        sectionView.addSubview(sectionName)
        return sectionView
    }
    
    
}


class NestedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
}
