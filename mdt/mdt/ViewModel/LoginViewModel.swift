//
//  LoginViewModel.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

final class LoginViewModel {
	
	var isFirstTimeLoad: Bool = true
	
	var onNeedToShowHome: (() -> Void)?
	var onNeedToShowRegister: (() -> Void)?
	var onNeedToShowErrorAlert: ((String?) -> Void)?
	var service: RESTServiceable = RESTService()
	
	func handleLoginTapped(username: String, password: String) {
		let loginRequest = LoginRequest(username: username, password: password)
		service.makeLoginRequest(loginRequest: loginRequest) { [weak self] (isLoginSuccess: Bool, errorMessage: String?) in
			if isLoginSuccess {
				KeychainHelper.cache(value: username, for: .username)
				self?.onNeedToShowHome?()
			} else {
				self?.onNeedToShowErrorAlert?(errorMessage)
			}
		}
	}
	
	func handleRegisterTapped() {
		onNeedToShowRegister?()
	}
}
