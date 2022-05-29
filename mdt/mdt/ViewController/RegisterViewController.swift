//
//  RegisterViewController.swift
//  mdt
//
//  Created by Fernando Prayogo on 29/05/22.
//

import Foundation
import UIKit

final class RegisterViewController: UIViewController {
	
	private let viewModel = RegisterViewModel()
	private let registerView: RegisterView?
	
	init() {
		registerView = RegisterView(registerViewModel: viewModel)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		registerView = RegisterView(registerViewModel: viewModel)
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		view.backgroundColor = .white
		createRegisterViews()
		configureViewModel()
	}
	
	private func configureViewModel() {
		viewModel.onNeedToShowErrorAlert = { [weak self] (errorMessage: String?) in
			guard let errorMessage = errorMessage else {
				return
			}
			DispatchQueue.main.async { [weak self] in
				self?.showAlert(message: errorMessage, title: "Register failed")
			}
		}
		
		viewModel.onNeedToShowRegisterSuccess = { [weak self] in
			DispatchQueue.main.async { [weak self] in
				self?.showAlert(message: "You can now login to your account", title: "Register success", actionClosure: { [weak self] _ in
					self?.dismiss(animated: true, completion: nil)
				})
			}
		}
		
		viewModel.onNeedToDismissViewController = { [weak self] in
			self?.dismiss(animated: true, completion: nil)
		}
	}
	
	private func createRegisterViews() {
		createBackButton()
		createUsernameTextField()
		createPasswordTextField()
		createConfirmPasswordTextField()
		createRegisterButton()
	}
	
	private func createBackButton() {
		if let registerView = registerView {
			view.addSubview(registerView.getBackButton())
		}
	}
	
	private func createUsernameTextField() {
		if let registerView = registerView {
			view.addSubview(registerView.getUsernameTextField())
		}
	}
	
	private func createPasswordTextField() {
		if let registerView = registerView {
			view.addSubview(registerView.getPasswordTextField())
		}
	}
	
	private func createConfirmPasswordTextField() {
		if let registerView = registerView {
			view.addSubview(registerView.getConfirmPasswordTextField())
		}
	}
	
	private func createRegisterButton() {
		if let registerView = registerView {
			view.addSubview(registerView.getRegisterButton())
		}
	}
}
