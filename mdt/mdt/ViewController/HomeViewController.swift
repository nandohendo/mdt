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
		//configureViewModel()
	}
	
	private func createHomeViews() {
		createLogoutButton()
		createAccountSummaryView()
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
}
