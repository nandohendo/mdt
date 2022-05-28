//
//  MockRESTService.swift
//  mdtTests
//
//  Created by Fernando Prayogo on 28/05/22.
//

import Foundation
@testable import mdt

final class MockRESTService: RESTServiceable {
	var isSuccess: Bool = true
	
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool) -> Void)) {
		completionHandler(isSuccess)
	}
}
