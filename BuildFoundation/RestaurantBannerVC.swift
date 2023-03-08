//
//  RestaurantBannerVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 10/03/23.
//

import Foundation
import UIKit


class RestaurantBannerVC: UIViewController {
    
    private let collectionView: UICollectionView =  {
        let layout = CustomHomeBannerLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden =  true
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        
        collectionView.backgroundColor = .gray
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
        ])
        collectionView.setHeightAndWidth(height: 200, width: self.view.frame.width)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = CustomHomeBannerLayout()
        collectionView.register(BannerCVC.self, forCellWithReuseIdentifier: "BannerCVC")
    }
    
    
}
extension RestaurantBannerVC: UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCVC", for: indexPath) as! BannerCVC
        return cell
    }
}

class BannerCVC: UICollectionViewCell {
    
    private let bannerImage: UIImageView =  {
        let banner = UIImageView(frame: .zero)
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(bannerImage)
        NSLayoutConstraint.activate([
            bannerImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            bannerImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            bannerImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
        ])
        bannerImage.setHeightAndWidth(height: 200, width: UIScreen.main.bounds.width)
        bannerImage.image = UIImage(named: "banner-user")
        
    }
}
class CustomHomeBannerLayout:UICollectionViewFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
