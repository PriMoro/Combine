import Foundation
import Combine

enum ExampleError: Swift.Error {
    case somethingWentWrong
}

let subject = PassthroughSubject<String, ExampleError>()

// The handleEvents operator lets you intercept
// All stages of a subscription lifecycle
let subscription = subject.handleEvents(receiveSubscription: { (subscription) in
        print("New subscription!")
    }, receiveOutput: { _ in
        print("Received new value!")
    }, receiveCompletion: { _ in
        print("A subscription completed")
    }, receiveCancel: {
        print("A subscription cancelled")
    })
    .replaceError(with: "Failure")
    .sink { (value) in
        print("Subscriber received value: \(value)")
    }

subject.send("Hello!")
subject.send("Hello again!")
subject.send("Hello for the last time!")
subject.send(completion: .failure(.somethingWentWrong))
subject.send("Hello?? :(")

subscription.cancel()

