import Foundation
import Combine
import UIKit

// error type we need
enum RequestError: Error {
    case sessionError(error: Error)
}

// we will send URLs through this publisher to trigger requests
let URLPublisher = PassthroughSubject<URL, RequestError>()

// use `flatMap` to turn a URL into a requested data publisher
let subscription = URLPublisher.flatMap { requestURL in
    URLSession.shared
        .dataTaskPublisher(for: requestURL)
        .mapError { error -> RequestError in
            RequestError.sessionError(error: error)
    }
}
.assertNoFailure()
.sink { result in
    print("Request completed!")
    _ = UIImage(data: result.data)
}

URLPublisher.send(URL(string: "https://httpbin.org/image/jpeg")!)
URLPublisher.send(URL(string: "https://httpbin.org/image/jpeg")!)
URLPublisher.send(URL(string: "https://httpbin.org/image/jpeg")!)
//URLPublisher.send(URL(string: "")!)

