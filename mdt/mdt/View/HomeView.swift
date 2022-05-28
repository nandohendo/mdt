//
//  HomeView.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation
import UIKit

final class HomeView: NSObject {
	
	private let logoutButton: UIButton = UIButton()
	private let balanceStackView: UIStackView = UIStackView()
	private let accountNumberStackView: UIStackView = UIStackView()
	private let usernameStackView: UIStackView = UIStackView()
	private let balanceIcon: UIImageView = UIImageView(image: UIImage(named: "money"))
	private let personIcon: UIImageView = UIImageView(image: UIImage(named: "person"))
	private let infoIcon: UIImageView = UIImageView(image: UIImage(named: "info"))

	
	private let balanceText: UILabel = UILabel()
	private let accountNumberText = UILabel()
	private let usernameText = UILabel()
	private let stackView: UIStackView = UIStackView()
	
	let flowLayout = UICollectionViewFlowLayout()

	private lazy var collectionView: UICollectionView = {
		flowLayout.scrollDirection = .vertical
		flowLayout.estimatedItemSize = CGSize(width: Device.screenWidth - 32, height: 54)
		flowLayout.minimumLineSpacing = 16
		
		let collectionView = UICollectionView(frame: CGRect(x: 0, y: stackView.bounds.maxY + 100, width: Device.screenWidth, height: Device.screenHeight * 0.5), collectionViewLayout: flowLayout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .white
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: "historyCell")
		collectionView.register(HistoryHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "historyHeaderCell")

		return collectionView
	}()

	let homeViewModel: HomeViewModel
	
	init(homeViewModel: HomeViewModel) {
		self.homeViewModel = homeViewModel
		super.init()
		
		configureHomeViewModel()
	}
	
	private func configureHomeViewModel() {
		homeViewModel.onNeedToReloadCollectionView = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				self?.collectionView.reloadData()
			}
		}
		
		homeViewModel.onNeedToReloadBasicInfo = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				self?.refreshBasicInfo()
			}
		}
		
		homeViewModel.getBalance()
		homeViewModel.getTransferHistory()
	}
	
	func getLogoutButton() -> UIButton {
		logoutButton.isUserInteractionEnabled = true
		logoutButton.setTitle("Logout", for: .normal)
		logoutButton.setTitleColor(.black, for: .normal)
		logoutButton.frame = CGRect(x: Device.screenWidth * 0.75, y: Device.screenHeight * 0.05, width: 96, height: 48)
		logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
		logoutButton.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
		return logoutButton
	}
	
	@objc func logoutTapped() {
		homeViewModel.handleLogoutTapped()
	}
	
	func refreshBasicInfo() {
		balanceText.text = String(homeViewModel.basicInfo?.0 ?? 0)
		accountNumberText.text = homeViewModel.basicInfo?.1
		usernameText.text = "Donald Trump"
	}
	
	func getAccountSummaryView() -> UIStackView {
		makeBalanceView()
		makeAccountNumberView()
		makeUsernameView()
		
		stackView.backgroundColor = .white
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .leading
		stackView.spacing = 16.0
		stackView.frame = CGRect(x: 0, y: logoutButton.bounds.maxY + 36, width: Device.screenWidth * 0.75, height: 125)
		stackView.roundCorners(corners: [.topRight, .bottomRight], radius: 24)
		stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
		stackView.isLayoutMarginsRelativeArrangement = true
		
		stackView.addArrangedSubview(balanceStackView)
		stackView.addArrangedSubview(accountNumberStackView)
		stackView.addArrangedSubview(usernameStackView)

		return stackView
	}
	
	private func makeBalanceView() {
		balanceIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
		balanceIcon.contentMode = .scaleAspectFit
		
		balanceText.frame = CGRect(x: 0, y: 0, width: (Device.screenWidth * 0.75) - 40, height: 24)
		balanceText.textAlignment = .left
		balanceText.font = .systemFont(ofSize: 24, weight: .heavy)
		
		balanceStackView.axis = .horizontal
		balanceStackView.distribution = .equalSpacing
		balanceStackView.alignment = .leading
		balanceStackView.spacing = 16.0
		balanceStackView.frame = CGRect(x: 0, y: logoutButton.bounds.maxY + 36, width: Device.screenWidth * 0.75, height: 24)
		
		balanceStackView.addArrangedSubview(balanceIcon)
		balanceStackView.addArrangedSubview(balanceText)
	}
	
	private func makeAccountNumberView() {
		infoIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
		infoIcon.contentMode = .scaleAspectFit
		
		accountNumberText.frame = CGRect(x: 0, y: 0, width: (Device.screenWidth * 0.75) - 40, height: 24)
		accountNumberText.text = "3321-323-732"
		accountNumberText.textAlignment = .left
		accountNumberText.font = .systemFont(ofSize: 16)
		
		accountNumberStackView.axis = .horizontal
		accountNumberStackView.distribution = .equalSpacing
		accountNumberStackView.alignment = .leading
		accountNumberStackView.spacing = 16.0
		accountNumberStackView.frame = CGRect(x: 24, y: 0, width: Device.screenWidth * 0.75, height: 24)
		
		accountNumberStackView.addArrangedSubview(infoIcon)
		accountNumberStackView.addArrangedSubview(accountNumberText)
	}
	
	private func makeUsernameView() {
		personIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
		personIcon.contentMode = .scaleAspectFit
		
		usernameText.frame = CGRect(x: 0, y: 0, width: (Device.screenWidth * 0.75) - 40, height: 24)
		usernameText.text = "Donald Trump"
		usernameText.textAlignment = .left
		usernameText.font = .systemFont(ofSize: 16)
		
		usernameStackView.axis = .horizontal
		usernameStackView.distribution = .equalSpacing
		usernameStackView.alignment = .leading
		usernameStackView.spacing = 16.0
		usernameStackView.frame = CGRect(x: 24, y: 0, width: Device.screenWidth * 0.75, height: 24)
		
		usernameStackView.addArrangedSubview(personIcon)
		usernameStackView.addArrangedSubview(usernameText)
	}
	
	func getHistoryCollectionView() -> UICollectionView {
		return collectionView
	}
	
}

extension HomeView: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		guard let sortedDate = homeViewModel.sortedDate else {
			return 0
		}
		return sortedDate.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let sortedDetail = homeViewModel.sortedDetail?[section] else {
			return 0
		}
		return sortedDetail.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as? HistoryCell ?? UICollectionViewCell()
		
		let headerCell = cell as? HistoryCell
		headerCell?.transactionDetail = homeViewModel.sortedDetail?[indexPath.section][indexPath.item]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: 60)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
	}
	
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		switch kind {
			
		case UICollectionView.elementKindSectionHeader:
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "historyHeaderCell", for: indexPath) as? HistoryHeaderCell ?? UICollectionReusableView()
			
			let historyHeaderCell = headerView as? HistoryHeaderCell
			let filteredTransactionDate = homeViewModel.sortedDate?[indexPath.section]

			guard let filteredTransactionDate = filteredTransactionDate else {
				return headerView
			}

			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"
			let date = dateFormatter.date(from: filteredTransactionDate)
			dateFormatter.dateFormat = "dd MMM yyyy"
			historyHeaderCell?.transactionDate = dateFormatter.string(from: date ?? Date())
			
			return headerView
			
		default:
			assert(false, "Unexpected element kind")
		}
	}
	
	
}
extension CGFloat {
	static func random() -> CGFloat {
		return CGFloat(arc4random()) / CGFloat(UInt32.max)
	}
}
extension UIColor {
	static func random() -> UIColor {
		return UIColor(
		   red:   .random(),
		   green: .random(),
		   blue:  .random(),
		   alpha: 1.0
		)
	}
}
