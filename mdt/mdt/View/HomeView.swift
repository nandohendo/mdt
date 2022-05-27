//
//  HomeView.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation
import UIKit

final class HomeView {
	
	private let logoutButton: UIButton = UIButton()
	private let stackView: UIStackView = UIStackView()

	let homeViewModel: HomeViewModel
	
	init(homeViewModel: HomeViewModel) {
		self.homeViewModel = homeViewModel
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
		
	}
	
	func getAccountSummaryView() -> UIStackView {
		let balanceText = UILabel()
		var newFrame = balanceText.frame
		newFrame.size.width = (Device.screenWidth * 0.75) - 16
		newFrame.size.height = 40
		balanceText.frame = newFrame
		balanceText.text = "SGD 21,421.33"
		balanceText.textAlignment = .left
		balanceText.font = .systemFont(ofSize: 24, weight: .heavy)
		
		let accountNumberText = UILabel()
		var newFrame2 = accountNumberText.frame
		newFrame2.size.width = (Device.screenWidth * 0.75) - 16
		newFrame2.size.height = 40
		accountNumberText.frame = newFrame2
		accountNumberText.text = "3321-323-732"
		accountNumberText.textAlignment = .left
		accountNumberText.font = .boldSystemFont(ofSize: 16)
		
		let usernameText = UILabel()
		var newFrame3 = usernameText.frame
		newFrame3.size.width = (Device.screenWidth * 0.75) - 16
		newFrame3.size.height = 40
		usernameText.frame = newFrame3
		usernameText.text = "Donald Trump"
		usernameText.textAlignment = .left
		usernameText.font = .boldSystemFont(ofSize: 16)
		
		stackView.backgroundColor = .white
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .leading
		stackView.spacing = 16.0
		stackView.frame = CGRect(x: 0, y: logoutButton.bounds.maxY + 36, width: Device.screenWidth * 0.75, height: 125)
		stackView.roundCorners(corners: [.topRight, .bottomRight], radius: 24)
		stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
		stackView.isLayoutMarginsRelativeArrangement = true
		
//		NSLayoutConstraint.activate([
//			stackView.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 20)
//		])
		stackView.addArrangedSubview(balanceText)
		stackView.addArrangedSubview(accountNumberText)
		stackView.addArrangedSubview(usernameText)
		//stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}
	
	
}
