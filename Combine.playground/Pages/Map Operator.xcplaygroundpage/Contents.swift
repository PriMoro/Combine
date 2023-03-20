import Foundation
import Combine

let intPublisher = PassthroughSubject<Int, Never>()

//intPublisher.sink { value in
//    let str = String(value)
//    print("Value: \(str)")
//}

[1,2,3,4,5,6]
    .publisher
    .map { String($0) }
    .sink { value in
        print("Value: \(value)")
    }

intPublisher
    .map { String($0) }
    .sink { value in
        print("Value: \(value)")
    }


intPublisher.send(1)
intPublisher.send(2)
intPublisher.send(3)
