//
//  RegisterViewModel.swift
//  mdt
//
//  Created by Fernando Prayogo on 29/05/22.
//

import Foundation

final class RegisterViewModel {
	
	var onNeedToShowRegisterSuccess: (() -> Void)?
	var onNeedToShowErrorAlert: ((String?) -> Void)?
	var onNeedToDismissViewController: (() -> Void)?
	var service: RESTServiceable = RESTService()
	
	func handleRegisterTapped(username: String, password: String) {
		let registerRequest = RegisterRequest(username: username, password: password)
		service.makeRegisterRequest(registerRequest: registerRequest) { [weak self] (isRegisterSuccess: Bool, errorMessage: String?) in
			if isRegisterSuccess {
				self?.onNeedToShowRegisterSuccess?()
			} else {
				self?.onNeedToShowErrorAlert?(errorMessage)
			}
		}
	}
	
	func handleBackTapped() {
		onNeedToDismissViewController?()
	}
}
