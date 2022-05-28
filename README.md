# Architecture

I am using MVVM for this project, the UI will be done programatically.

Since I will not be using RxSwift, the code will depend a lot on closures, example:

`HomeView`

```
@objc func logoutTapped() {
		homeViewModel.handleLogoutTapped()
}
```

`HomeViewModel`

```
var onNeedToLogout: (() -> Void)?

func handleLogoutTapped() {
		onNeedToLogout?()
}

```

`HomeViewController`

```
private func configureViewModel() {
		viewModel.onNeedToLogout = { [weak self] in
			self?.dismiss(animated: true, completion: nil)
		}
	}
```


# Library

- KeychainSwift 

Wrapping Keychain code which will be used for storing user's personal data

- Quick and Nimble

Unit testing framework to refine the way we write unit tests

# Code

- Utilities

There a few classes here, but I will explain two of the most frequently used which is `Device` and `RESTService`

`Device` class provide `screenWidth` and `screenHeight` which I used a lot to write UI code programatically.

`RESTService` is the API manager for my project, it will handle all the APIs call. 
I have not optimized the code though, for me it's still too cluttered because I need to repeatedly write the same code for every API call.

`RESTService` also has `RESTServiceable` protocol for unit testing purpose, so we can execute unit test without actually hitting network request. You will see the usage below.

- Login

All the UIs are coded in `LoginView` class. It's a simple combination of `UITextField` and `UIButton`.

I also listen to the text field input changes to determine whether Login button can be tapped or no.

```
@objc func usernameTextFieldDidChange(_ textField: UITextField) {
		loginButton.isUserInteractionEnabled = !(textField.text?.isEmpty ?? true)
		loginButton.alpha = (textField.text?.isEmpty ?? true) ? 0.5 : 1
}
```

`LoginViewModel` only contains the function to call login API, so the unit test also tests that functionality. 

To mock the network call, I create a protocol for `RESTService` class which is called `RESTServiceable`.

```
protocol RESTServiceable {
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool) -> Void))
}

```

The mock will pass completionHandler based on `isSuccess` boolean:

```
final class MockRESTService: RESTServiceable {
	var isSuccess: Bool = true
	
	func makeLoginRequest(loginRequest: LoginRequest, completionHandler: @escaping ((Bool) -> Void)) {
		completionHandler(isSuccess)
	}
}

```

After setting up the mock, now we can already execute it. Below is an example of how I write unit test using Quick and Nimble framework

```
describe("handle login tapped") {
			context("API request is success") {
				it("onNeedToShowHome is triggered") {
					var isShowHomeCalled = false
					mockRESTService.isSuccess = true
					
					viewModel.onNeedToShowHome = {
						isShowHomeCalled = true
					}
					viewModel.handleLoginTapped(username: "a", password: "b")
					expect(isShowHomeCalled).to(beTrue())
				}
			}
			
			context("API request is failed") {
				it("onNeedToShowHome is triggered") {
					var isShowAlertCalled = false
					mockRESTService.isSuccess = false
					
					viewModel.onNeedToShowErrorAlert = {
						isShowAlertCalled = true
					}
					viewModel.handleLoginTapped(username: "a", password: "b")
					expect(isShowAlertCalled).to(beTrue())
				}
			}
}
```

- Home/Dashboard

There are several functionalities in Home page. 

The first one is showing user info, I coded the UI with several `UIStackView`.

Then, there is user transaction's history. I coded the UI using `UICollectionView` with multiple sections, by showing the transaction date in header part of the collection view section, and the transactions on the collection view cells.

The main challenge here is the data for the transaction history. The data received is sent in one big JSON, without any separation for each date, so I need to group it up first.

First things first, I try to group transactions based on their transaction date using this code:

```
// Separate date by "T" wildcard
// Date format: 2022-03-12T15:13:58.927Z
let dict = Dictionary(grouping: transferResponse.data) {
				$0.transactionDate.components(separatedBy: "T").first
}
```

Now I have dictionary with grouped transactions based on their transaction date. The key is the transaction date, ex: `2022-03-12`. And the value is array of transaction details. 

The problem here is this particular dictionary is not sorted, while we need to show sorted transactions for user. My next approach is to sort the dictionary by the keys.

```
let sortedArray = dict.sorted( by: { $0.0 ?? "" > $1.0 ?? "" })
self.sortedDate = sortedArray.map {
	return $0.0 ?? ""
}
self.sortedDetail = sortedArray.map {
	return $0.1
}
```

Now we have `sortedDate` and `sortedDetail` which contains sorted transaction date and transaction detail respectively.

The date will be used to fill up the collection view header, meanwhile the detail will be used to fill up the collection view cells.