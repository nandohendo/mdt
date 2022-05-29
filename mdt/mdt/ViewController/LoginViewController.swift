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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Clear text fields after coming back from other flow
		guard !viewModel.isFirstTimeLoad else {
			viewModel.isFirstTimeLoad = false
			return
		}
		
		loginView?.clearTextFields()
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
		
		viewModel.onNeedToShowRegister = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				let registerViewController = RegisterViewController()
				registerViewController.modalPresentationStyle = .fullScreen
				self?.present(registerViewController, animated: true, completion: nil)
			}
		}
	}
	
	private func createLoginViews() {
		createHeader()
		createUsernameTextField()
		createPasswordTextField()
		createLoginButton()
		createRegisterButton()
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
	
	private func createRegisterButton() {
		if let loginView = loginView {
			view.addSubview(loginView.getRegisterButton())
		}
	}
}
