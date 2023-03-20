import Foundation
import Combine

// Combine Latest

// input from text fields with subjects
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

// combine the latest value of each input to compute a validation
let validatedCredentialsSubscription = Publishers
    .CombineLatest(usernamePublisher, passwordPublisher)
    .map { (username, password) -> Bool in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("CombineLatest: are the credentials valid? \(valid)")
    }

usernamePublisher.send("avanderlee")
passwordPublisher.send("weakpass")
passwordPublisher.send("verystrongpassword")
passwordPublisher.send("strongpassword")

// Merge
let publisher1 = [1,2,3,4,5].publisher
let publisher2 = [300,400,500].publisher

let mergedPublishersSubscription = Publishers
    .Merge(publisher1, publisher2)
    .sink { value in
        print("Merge: subscription received value \(value)")
}
