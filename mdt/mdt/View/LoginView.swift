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
	let registerButton = UIButton()
	let usernameTextField = UITextField()
	let passwordTextField = UITextField()
	
	func getHeader() -> UILabel {
		let loginHeader = UILabel()
		loginHeader.textColor = .black
		loginHeader.font = UIFont.boldSystemFont(ofSize: 24)
		loginHeader.frame = CGRect(x: 24, y: Device.screenHeight * 0.15, width: Device.screenWidth - 48, height: 24)
		loginHeader.text = "Welcome"
		return loginHeader
	}
	
	func getUsernameTextField() -> UITextField {
		usernameTextField.setLeftPaddingPoints(16)
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
		passwordTextField.setLeftPaddingPoints(16)
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
		loginButton.layer.cornerRadius = 24
		loginButton.frame = CGRect(x: 24, y: Device.screenHeight * 0.7, width: Device.screenWidth - 48, height: 48)
		loginButton.alpha = 0.5
		loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
		return loginButton
	}
	
	@objc func loginTapped() {
		loginViewModel.handleLoginTapped(username: (usernameTextField.text ?? ""), password: (passwordTextField.text ?? ""))
	}
	
	func getRegisterButton() -> UIButton {
		registerButton.setTitle("REGISTER", for: .normal)
		registerButton.setTitleColor(.black, for: .normal)
		registerButton.backgroundColor = .white
		registerButton.layer.cornerRadius = 24
		registerButton.frame = CGRect(x: 24, y: Device.screenHeight * 0.8, width: Device.screenWidth - 48, height: 48)
		registerButton.layer.borderColor = UIColor.black.cgColor
		registerButton.layer.borderWidth = 2
		registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
		return registerButton
	}
	
	@objc func registerTapped() {
		loginViewModel.handleRegisterTapped()
	}
	
	func clearTextFields() {
		usernameTextField.text = ""
		passwordTextField.text = ""
	}
	
}

extension LoginView {
	@objc func usernameTextFieldDidChange(_ textField: UITextField) {
		loginButton.isUserInteractionEnabled = !(textField.text?.isEmpty ?? true)
		loginButton.alpha = (textField.text?.isEmpty ?? true) ? 0.5 : 1
	}
	
}
