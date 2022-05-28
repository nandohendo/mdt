//
//  RESTService.swift
//  mdt
//
//  Created by Fernando Prayogo on 27/05/22.
//

import Foundation

protocol RESTServiceable {
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool) -> Void))
	func makeGetBalanceRequest(completionHandler: @escaping ((Bool, BalanceResponse?) -> Void))
	func makeGetHistoryRequest(completionHandler: @escaping ((Bool, TransferResponse?) -> Void))
}

final class RESTService: RESTServiceable {
	
	enum HTTPMethod: String {
		case get = "GET"
		case post = "POST"
	}

	private let session = URLSession.shared
	private let baseURL: String = "https://green-thumb-64168.uc.r.appspot.com"
	
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool) -> Void)) {
		var request = getURLRequest(endPoint: "login", httpMethod: .post)
		request.httpBody = try? JSONEncoder().encode(loginRequest)

		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard let data = data else {
				return
			}
			do {
				let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
				
				if loginResponse.status != "success" {
					completionHandler(false)
					return
				}
				
				KeychainHelper.cache(value: loginResponse.token, for: .token)
				KeychainHelper.cache(value: loginResponse.username, for: .username)
				completionHandler(true)
			} catch {
				
			}
		})

		task.resume()
	}
	
	func makeGetBalanceRequest(completionHandler: @escaping ((Bool, BalanceResponse?) -> Void)) {
		let request = getURLRequest(endPoint: "balance", httpMethod: .get)

		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard let data = data else {
				return
			}
			do {
				let balanceResponse = try JSONDecoder().decode(BalanceResponse.self, from: data)
				
				if balanceResponse.status != "success" {
					completionHandler(false, nil)
					return
				}
				
				completionHandler(true, balanceResponse)
			} catch {
				completionHandler(false, nil)
				print("error")
			}
		})

		task.resume()
	}
	
	func makeGetPayeeRequest(completionHandler: @escaping ((Bool, PayeeResponse?) -> Void)) {
		let request = getURLRequest(endPoint: "payees", httpMethod: .get)

		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard let data = data else {
				return
			}
			do {
				
				// should check for status from response too
				let payeeResponse = try JSONDecoder().decode(PayeeResponse.self, from: data)
				completionHandler(true, payeeResponse)
			} catch {
				completionHandler(false, nil)
				print("error")
			}
		})

		task.resume()
	}
	
	func makeGetHistoryRequest(completionHandler: @escaping ((Bool, TransferResponse?) -> Void)) {
		let request = getURLRequest(endPoint: "transactions", httpMethod: .get)

		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard let data = data else {
				return
			}
			do {
				let historyResponse = try JSONDecoder().decode(TransferResponse.self, from: data)
				
				if historyResponse.status != "success" {
					completionHandler(false, nil)
					return
				}
				
				completionHandler(true, historyResponse)
			} catch {
				completionHandler(false, nil)
				print("error")
			}
		})

		task.resume()
	}
	
	private func getURLRequest(endPoint: String, httpMethod: HTTPMethod) -> URLRequest {
		var request = URLRequest(url: URL(string: "\(baseURL)/\(endPoint)")!)
		request.httpMethod = httpMethod.rawValue
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		if endPoint != "register" && endPoint != "login" {
			request.addValue((KeychainHelper.value(for: .token) ?? ""), forHTTPHeaderField: "Authorization")
		}
		return request
	}
	
}
