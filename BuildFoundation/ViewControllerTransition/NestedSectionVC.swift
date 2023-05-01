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
    
    var sections:[Section] = [Section(title: "Sports", subSection: [SubSection(title: "Bat-and-ball", row: [Row(title: "Baseball"),Row(title: "Softball"),Row(title: "Cricket")]),SubSection(title: "Hockey", row: [Row(title: " Field Hockey"),Row(title: "Roller Hockey"),Row(title: "Ice Hockey")])]),
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
        let sectionItems = sections[section]
        var numberOfRows: Int = sectionItems.subSection.count // For second level section headers
        for rowItems in 0..<sectionItems.subSection.count  {
            numberOfRows += sectionItems.subSection.count // For actual table rows
           }
           return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var sectionItems = sections[indexPath.section]
            var sectionHeaders = self.sections[indexPath.section]
            let itemAndSubsectionIndex: IndexPath? = computeItemAndSubsectionIndex(for: indexPath)
            let subsectionIndex = Int(itemAndSubsectionIndex?.section ?? 0)
            let itemIndex: Int? = itemAndSubsectionIndex?.row

            if (itemIndex ?? 0) < 0 {
                // Section header
                let cell = tableView.dequeueReusableCell(withIdentifier: "NestedSubSectionTableViewCell", for: indexPath) as! NestedSubSectionTableViewCell
                cell.backgroundColor = .red
                cell.titleLabel.text = sections[indexPath.section].subSection[subsectionIndex ?? 0].title
                return cell
            } else {
                // Row Item
                let cell = tableView.dequeueReusableCell(withIdentifier: "NestedTableViewCell", for: indexPath) as! NestedTableViewCell
                cell.backgroundColor = .green
                cell.titleLabel.text = sections[indexPath.section].subSection[subsectionIndex ?? 0].row[itemIndex ?? 0].title
                return cell
                
            }
        
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
    
    func computeItemAndSubsectionIndex(for indexPath: IndexPath?) -> IndexPath? {
        var sectionItems = sections[Int(indexPath?.section ?? 0)]
        var itemIndex: Int? = indexPath?.row
        var subsectionIndex: Int = 0
        for i in 0..<sectionItems.subSection.count {
            // First row for each section item is header
            itemIndex = (itemIndex ?? 0) - 1
            // Check if the item index is within this subsection's items
            let subsectionItems = sectionItems
            if (itemIndex ?? 0) < Int(subsectionItems.subSection.count ?? 0) {
                subsectionIndex = i
                break
            } else {
                itemIndex! -= subsectionItems.subSection.count ?? 0
            }
        }
        return IndexPath(row: itemIndex ?? 0, section: subsectionIndex)
    }
    
    
}


class NestedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
}


class NestedSubSectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel:UILabel!
}
