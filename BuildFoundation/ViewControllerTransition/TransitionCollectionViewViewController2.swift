//
//  TransitionCollectionViewViewController2.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/03/23.
//

import UIKit

class TransitionCollectionViewViewController2: UIViewController {
    var data: TransitionCellData!

    @IBOutlet private(set) var locationImageView: UIImageView!
    @IBOutlet private(set) var locationLabel: UILabel!
    @IBOutlet private(set) var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let cross = #imageLiteral(resourceName: "cross").withRenderingMode(.alwaysTemplate)
        closeButton.setImage(cross, for: .normal)
        closeButton.tintColor = .white

        locationImageView.image = data.image
        locationLabel.text = data.title
        locationImageView.layer.cornerRadius = 50
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }

}
