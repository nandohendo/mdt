//
//  LoginViewController.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import UIKit

final class LoginViewController: UIViewController {

	private let viewModel = LoginViewModel()
	private let loginView: LoginView?
	
	init() {
		loginView = LoginView(loginViewModel: viewModel)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		loginView = LoginView(loginViewModel: viewModel)
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		createLoginViews()
		configureViewModel()
	}
	
	private func configureViewModel() {
		viewModel.onNeedToShowHome = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				let homeViewController = HomeViewController()
				homeViewController.modalPresentationStyle = .fullScreen
				self?.present(homeViewController, animated: true, completion: nil)
			}
		}
		
		viewModel.onNeedToShowErrorAlert = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				self?.showAlert(message: "Failed to login, please retry")
			}
		}
	}
	
	private func createLoginViews() {
		createHeader()
		createUsernameTextField()
		createPasswordTextField()
		createLoginButton()
	}

	private func createHeader() {
		if let loginView = loginView {
			view.addSubview(loginView.getHeader())
		}
	}
	
	private func createUsernameTextField() {
		if let loginView = loginView {
			view.addSubview(loginView.getUsernameTextField())
		}
	}
	
	private func createPasswordTextField() {
		if let loginView = loginView {
			view.addSubview(loginView.getPasswordTextField())
		}
	}
	
	private func createLoginButton() {
		if let loginView = loginView {
			view.addSubview(loginView.getLoginButton())
		}
	}
}
