//
//  RegisterView.swift
//  mdt
//
//  Created by Fernando Prayogo on 29/05/22.
//

import Foundation
import UIKit

final class RegisterView {
	
	let registerViewModel: RegisterViewModel
	
	init(registerViewModel: RegisterViewModel) {
		self.registerViewModel = registerViewModel
	}
	
	let registerButton = UIButton()
	let usernameTextField = UITextField()
	let passwordTextField = UITextField()
	let confirmPasswordTextField = UITextField()
	let backButton = UIButton()
	
	func getBackButton() -> UIButton {
		backButton.setImage(UIImage(named: "back"), for: .normal)
		backButton.frame = CGRect(x: 16, y: 48, width: 24, height: 24)
		backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
		return backButton
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
		passwordTextField.frame = CGRect(x: 24, y: usernameTextField.frame.origin.y + 64, width: Device.screenWidth - 48, height: 48)
		passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)),
						for: .editingChanged)
		passwordTextField.isSecureTextEntry = true
		return passwordTextField
	}
	
	func getConfirmPasswordTextField() -> UITextField {
		confirmPasswordTextField.setLeftPaddingPoints(16)
		confirmPasswordTextField.placeholder = "Confirm Password"
		confirmPasswordTextField.layer.cornerRadius = 8
		confirmPasswordTextField.layer.borderColor = UIColor.black.cgColor
		confirmPasswordTextField.layer.borderWidth = 2
		confirmPasswordTextField.frame = CGRect(x: 24, y: passwordTextField.frame.origin.y + 64, width: Device.screenWidth - 48, height: 48)
		confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldDidChange(_:)),
						for: .editingChanged)
		confirmPasswordTextField.isSecureTextEntry = true
		return confirmPasswordTextField
	}
	
	func getRegisterButton() -> UIButton {
		registerButton.isUserInteractionEnabled = false
		registerButton.setTitle("REGISTER", for: .normal)
		registerButton.backgroundColor = .black
		registerButton.layer.cornerRadius = 24
		registerButton.frame = CGRect(x: 24, y: Device.screenHeight * 0.8, width: Device.screenWidth - 48, height: 48)
		registerButton.alpha = 0.5
		registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
		return registerButton
	}
	
	@objc func registerTapped() {
		guard let username = usernameTextField.text,
			  let password = passwordTextField.text else {
				  return
			  }
		registerViewModel.handleRegisterTapped(username: username, password: password)
	}
	
	@objc func backTapped() {
		registerViewModel.handleBackTapped()
	}
}

// Can be improved by listening to all of them at once using Rx
extension RegisterView {
	@objc func usernameTextFieldDidChange(_ textField: UITextField) {
		let isUsernameEmpty = usernameTextField.text?.isEmpty ?? true
		let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
		let isPasswordIdentical = (passwordTextField.text == confirmPasswordTextField.text)
		let isButtonTappable = !(isUsernameEmpty || isPasswordEmpty || !isPasswordIdentical)
		
		registerButton.isUserInteractionEnabled = isButtonTappable
		registerButton.alpha = isButtonTappable ? 1 : 0.5
	}
	
	@objc func passwordTextFieldDidChange(_ textField: UITextField) {
		let isUsernameEmpty = usernameTextField.text?.isEmpty ?? true
		let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
		let isPasswordIdentical = (passwordTextField.text == confirmPasswordTextField.text)
		let isButtonTappable = !(isUsernameEmpty || isPasswordEmpty || !isPasswordIdentical)
		
		registerButton.isUserInteractionEnabled = isButtonTappable
		registerButton.alpha = isButtonTappable ? 1 : 0.5
	}
	
	@objc func confirmPasswordTextFieldDidChange(_ textField: UITextField) {
		let isUsernameEmpty = usernameTextField.text?.isEmpty ?? true
		let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
		let isPasswordIdentical = (passwordTextField.text == confirmPasswordTextField.text)
		print(isUsernameEmpty, isPasswordEmpty, isPasswordIdentical)
		let isButtonTappable = !(isUsernameEmpty || isPasswordEmpty || !isPasswordIdentical)
		
		registerButton.isUserInteractionEnabled = isButtonTappable
		registerButton.alpha = isButtonTappable ? 1 : 0.5
	}
}
