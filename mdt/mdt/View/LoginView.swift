//
//  LoginView.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation
import UIKit

final class LoginView {
	
	let loginViewModel: LoginViewModel
	
	init(loginViewModel: LoginViewModel) {
		self.loginViewModel = loginViewModel
	}
	
	let loginButton = UIButton()
	let usernameTextField = UITextField()
	let passwordTextField = UITextField()
	
	func getHeader() -> UILabel {
		let loginHeader = UILabel()
		loginHeader.textColor = .black
		loginHeader.font = UIFont.boldSystemFont(ofSize: 20)
		loginHeader.frame = CGRect(x: 24, y: Device.screenHeight * 0.15, width: Device.screenWidth - 48, height: 24)
		loginHeader.text = "Login"
		return loginHeader
	}
	
	func getUsernameTextField() -> UITextField {
		usernameTextField.placeholder = "Username"
		usernameTextField.layer.cornerRadius = 8
		usernameTextField.layer.borderColor = UIColor.black.cgColor
		usernameTextField.layer.borderWidth = 2
		usernameTextField.frame = CGRect(x: 24, y: Device.screenHeight * 0.25, width: Device.screenWidth - 48, height: 48)
		usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)),
						for: .editingChanged)
		return usernameTextField
	}
	
	func getPasswordTextField() -> UITextField {
		passwordTextField.placeholder = "Password"
		passwordTextField.layer.cornerRadius = 8
		passwordTextField.layer.borderColor = UIColor.black.cgColor
		passwordTextField.layer.borderWidth = 2
		passwordTextField.frame = CGRect(x: 24, y: Device.screenHeight * 0.4, width: Device.screenWidth - 48, height: 48)
		passwordTextField.isSecureTextEntry = true
		return passwordTextField
	}
	
	func getLoginButton() -> UIButton {
		loginButton.isUserInteractionEnabled = false
		loginButton.setTitle("LOGIN", for: .normal)
		loginButton.backgroundColor = .black
		loginButton.frame = CGRect(x: 24, y: Device.screenHeight * 0.8, width: Device.screenWidth - 48, height: 48)
		loginButton.alpha = 0.5
		loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
		return loginButton
	}
	
	@objc func loginTapped() {
		loginViewModel.handleLoginTapped(username: (usernameTextField.text ?? ""), password: (passwordTextField.text ?? ""))
	}
}

extension LoginView {
	@objc func usernameTextFieldDidChange(_ textField: UITextField) {
		loginButton.isUserInteractionEnabled = !(textField.text?.isEmpty ?? true)
		loginButton.alpha = (textField.text?.isEmpty ?? true) ? 0.5 : 1
	}
	
}
