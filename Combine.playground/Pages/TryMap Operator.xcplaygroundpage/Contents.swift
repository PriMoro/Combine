import Foundation
import Combine

enum DefinedErrors: Error {
    case errorStringToInt
}

func mapsStringToInt(with str: String) throws -> Int {
    guard let result = Int(str) else {
        throw DefinedErrors.errorStringToInt
    }
    return result
}

let publisher = PassthroughSubject<String, DefinedErrors>()

publisher
    .tryMap{ value in
       try mapsStringToInt(with: value)
    }
    .sink { finished in
    print(finished)
} receiveValue: { value in
    print(value)
}

publisher.send("50")
publisher.send("1050")
publisher.send("cuatro")
publisher.send("7")


