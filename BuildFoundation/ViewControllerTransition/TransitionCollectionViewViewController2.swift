//
//  TransitionCollectionViewViewController2.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/03/23.
//

import UIKit

class TransitionCollectionViewViewController2: UIViewController {
    
    
    @IBOutlet weak var avatarView: UIImageView!
    var data: TransitionCellData!

    @IBOutlet weak var transition2CV: UICollectionView!
   
    @IBOutlet private(set) var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let cross = #imageLiteral(resourceName: "cross").withRenderingMode(.alwaysTemplate)
        closeButton.setImage(cross, for: .normal)
        closeButton.tintColor = .white
        avatarView.image = data.image
//        avatarView.layer.masksToBounds = true
//        avatarView.layer.cornerRadius = 20
//        transition2CV.register(Transition2CVC.self, forCellWithReuseIdentifier: "Transition2CVC")
//        transition2CV.delegate = self
//        transition2CV.dataSource = self
//        transition2CV.reloadData()
        

      
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension TransitionCollectionViewViewController2: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Transition2CVC", for: indexPath) as! Transition2CVC
//        cell.configure(data: data)
        cell.locationImageView.image = data.image
        cell.locationLabel.text = data.title
        cell.locationImageView.layer.cornerRadius = 50
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - Constants.cellSpacing)
        return .init(width: width, height: 200)
    }
    
    enum Constants {

        static let cellSpacing: CGFloat = 8
    }
    
    func getImage()->UIView?{
        let cell = self.transition2CV.cellForItem(at: IndexPath(row: 0, section: 0)) as? Transition2CVC
        return cell?.locationImageView 
    }
}

class Transition2CVC: UICollectionViewCell{
    
    @IBOutlet var locationImageView: UIImageView!
    @IBOutlet var locationLabel: UILabel!
    
   
}
