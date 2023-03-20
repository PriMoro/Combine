import Foundation
import Combine

let publisher = PassthroughSubject<String, Never>()

publisher
    .filter{ $0.count > 6 }
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }

publisher.send("hello")
publisher.send("world")
publisher.send("!")
publisher.send("combine")
