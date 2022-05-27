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
	
	func makeLoginRequest(loginRequest: LoginRequest) {
		var request = URLRequest(url: URL(string: "\(baseURL)/login")!)
		request.httpMethod = "POST"
		request.httpBody = try? JSONEncoder().encode(loginRequest)
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			guard let data = data else {
				return
			}
			do {
				let json = try JSONDecoder().decode(LoginResponse.self, from: data)
				print(json)
			} catch {
				print("error")
			}
		})

		task.resume()
	}
	
}
