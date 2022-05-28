//
//  SelfSizingCollectionView.swift
//  mdt
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation
import UIKit

class SelfSizingCollectionView: UICollectionView {
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		commonInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}

	private func commonInit() {
		isScrollEnabled = false
	}

	override var contentSize: CGSize {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}

	override func reloadData() {
		super.reloadData()
		self.invalidateIntrinsicContentSize()
	}

	override var intrinsicContentSize: CGSize {
		return contentSize
	}
}
