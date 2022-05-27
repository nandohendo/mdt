//
//  RESTService.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

final class RESTService {

	private let session = URLSession.shared
	private let baseURL: String = "https://green-thumb-64168.uc.r.appspot.com"
	
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool) -> Void)) {
		var request = URLRequest(url: URL(string: "\(baseURL)/login")!)
		request.httpMethod = "POST"
		request.httpBody = try? JSONEncoder().encode(loginRequest)
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard let data = data else {
				return
			}
			do {
				let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
				KeychainHelper.cache(value: loginResponse.token, for: .token)
				KeychainHelper.cache(value: loginResponse.username, for: .username)
				completionHandler(true)
			} catch {
				completionHandler(false)
				print("error")
			}
		})

		task.resume()
	}
	
	func makeGetBalanceRequest(completionHandler: @escaping ((Bool) -> Void)) {
		var request = URLRequest(url: URL(string: "\(baseURL)/balance")!)
		request.httpMethod = "GET"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue((KeychainHelper.value(for: .token) ?? ""), forHTTPHeaderField: "Authorization")

		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard let data = data else {
				return
			}
			do {
				
				// should check for status from response too
				let balanceResponse = try JSONDecoder().decode(BalanceResponse.self, from: data)
				completionHandler(true)
			} catch {
				completionHandler(false)
				print("error")
			}
		})

		task.resume()
	}
	
}
