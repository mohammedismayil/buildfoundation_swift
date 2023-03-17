//
//  SampleTransitionImages.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 17/03/23.
//

import Foundation
import UIKit

struct TransitionCellData {

    let image: UIImage
    let title: String
}

class SampleTransitionImages {

    private init() {}

    static let data: [TransitionCellData] = [
        .init(image: #imageLiteral(resourceName: "TransitionImages/1"), title: "Seychelles"),
        .init(image: #imageLiteral(resourceName: "TransitionImages/2"), title: "Königssee"),
        .init(image: #imageLiteral(resourceName: "TransitionImages/5"), title: "Zanzibar"),
        .init(image: #imageLiteral(resourceName: "TransitionImages/6"), title: "Serengeti"),
        .init(image: #imageLiteral(resourceName: "TransitionImages/3"), title: "Castle"),
        .init(image: #imageLiteral(resourceName: "TransitionImages/4"), title: "Kyiv"),
        .init(image: #imageLiteral(resourceName: "TransitionImages/7"), title: "Munich"),
        .init(image: #imageLiteral(resourceName: "TransitionImages/8"), title: "Lake")
    ]

}
