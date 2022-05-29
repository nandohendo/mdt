//
//  HomeViewController.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
	
	private let viewModel = HomeViewModel()
	private let homeView: HomeView?
	
	init() {
		homeView = HomeView(homeViewModel: viewModel)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		homeView = HomeView(homeViewModel: viewModel)
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .init(white: 0.96, alpha: 1)
		createHomeViews()
		configureViewModel()
	}
	
	private func configureViewModel() {
		viewModel.onNeedToLogout = { [weak self] in
			
			guard let self = self else {
				return
			}
			
			if self == UIApplication.shared.keyWindow?.rootViewController {
				let loginViewController = LoginViewController()
				loginViewController.modalPresentationStyle = .fullScreen
				self.present(loginViewController, animated: true, completion: nil)
			} else {
				self.dismiss(animated: true, completion: nil)
			}
		}
	}
	
	private func createHomeViews() {
		createLogoutButton()
		createAccountSummaryView()
		createHistoryCollectionView()
	}
	
	private func createLogoutButton() {
		if let homeView = homeView {
			view.addSubview(homeView.getLogoutButton())
		}
	}
	
	private func createAccountSummaryView() {
		if let homeView = homeView {
			view.addSubview(homeView.getAccountSummaryView())
		}
	}
	
	private func createHistoryCollectionView() {
		if let homeView = homeView {
			view.addSubview(homeView.getHistoryCollectionView())
		}
	}
	
	deinit {
		print("HomeViewController deallocated")
	}
}
