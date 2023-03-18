//
//  TransitionCollectionViewViewController.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/03/23.
//

import UIKit

class TransitionCollectionViewViewController: UIViewController {

    var selectedCell: TransitionCollectionViewCell?
    var selectedCellImageViewSnapshot: UIView?

    @IBOutlet private var transitioncollectionView: UICollectionView!
    
    

    var transitionManager = ViewControllerTransitionManager()
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.isNavigationBarHidden =  true
//        self.view.backgroundColor = .white

        

//        self.transitioncollectionView.register(TransitionCollectionViewCell.self, forCellWithReuseIdentifier: "TransitionCollectionViewCell")
//        transitioncollectionView.delegate = self
        
        transitioncollectionView.delegate = self
        transitioncollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.minimumInteritemSpacing = Constants.cellSpacing
        transitioncollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    

    func presentSecondViewController(with data: TransitionCellData) {
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TransitionCollectionViewViewController2") as! TransitionCollectionViewViewController2

        // 4
        secondViewController.transitioningDelegate = transitionManager

        transitionManager.delegate = self
        secondViewController.modalPresentationStyle = .fullScreen
        secondViewController.data = data
        present(secondViewController, animated: true)
    }
}

extension TransitionCollectionViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SampleTransitionImages.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransitionCollectionViewCell", for: indexPath) as! TransitionCollectionViewCell
        cell.configure(with: SampleTransitionImages.data[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 6
        selectedCell = collectionView.cellForItem(at: indexPath) as? TransitionCollectionViewCell
        // 7
        selectedCellImageViewSnapshot = selectedCell?.locationImageView.snapshotView(afterScreenUpdates: false)
        
        presentSecondViewController(with: SampleTransitionImages.data[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - Constants.cellSpacing) / 2
        return .init(width: width, height: width)
    }
}
extension TransitionCollectionViewViewController: TransitionManagerDelegate {
    func requiredVC()->UIView {
        return selectedCellImageViewSnapshot ?? UIView()
    }
}
//extension TransitionCollectionViewViewController: UIViewControllerTransitioningDelegate {
//
//    // 2
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        // 16
//        guard let firstViewController = presenting as? TransitionCollectionViewViewController,
//            let secondViewController = presented as? TransitionCollectionViewViewController2,
//            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
//            else { return nil }
//
//        animator = ViewControllerTransition(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
//        return animator
//    }
//
//    // 3
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        // 17
//        guard let secondViewController = dismissed as? TransitionCollectionViewViewController2,
//            let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
//            else { return nil }
//
//        animator = ViewControllerTransition(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
//        return animator
//    }
//}

extension TransitionCollectionViewViewController {

    enum Constants {

        static let cellSpacing: CGFloat = 8
    }
}


final class TransitionCollectionViewCell: UICollectionViewCell {

    @IBOutlet var locationImageView: UIImageView!
    @IBOutlet var locationLabel: UILabel!

    private lazy var setupOnce: Void = {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }()


    override func layoutSubviews() {
        super.layoutSubviews()

        _ = setupOnce
    }

    func configure(with cellData: TransitionCellData) {
        locationImageView.image = cellData.image
        locationLabel.text = cellData.title
        locationImageView.frame = CGRect(x: 200, y: 700, width: 50, height: 50)
    }
}
