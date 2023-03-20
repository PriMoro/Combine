import UIKit
import Combine

let myArray = [1,2,3,4,5]
let myPubliser = myArray.publisher // create a publisher that publish events/values

// let just = Just(["1", "2", "3", "4"]) another way to create a publisher

// we need to _subscribe_ to receive values (here using a sink with a closure)

let cancellable = myPubliser.sink { isFinished in
    print("isFinished: \(isFinished)") // only its called when we received all values
} receiveValue: { value in
    print("Value received: \(value)") // its called by each value into array, publish a series of values immediately
}

// assign publisher values to a property on an object

class Channel {
    var numberOfSubs: Int = 0 {
        didSet {
            print("\(numberOfSubs)")
        }
    }
}

let justInteger = Just(2222)
let channel = Channel()
justInteger.assign(to: \Channel.numberOfSubs, on: channel)
print(justInteger)
channel.numberOfSubs

// ----

let publisher2 = [1,2,3,4,5].publisher

print("")
class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
let subscription3 = publisher2.assign(to: \.property, on: object)


// Combine
// pipelines por donde van a viajar nuestros valores/data a lo largo del tiempo
// publisher -> publican la info en la pipeline
// subscriber -> suscribirse a la info del publisher para agarrarla
// una tuberia donde se publica informacion y todos los subscriptos, pueden obtener los valores
// se puede usar un publisher pra que todos los elemnetos del array se publiquen cuando haya un subscriber
// un publisher define como son producidos sus valores o errores. siempre que creamos un publisher, se define un output(tipo de valor que envia) y un failure(tipo de error que envia)

// necesitamos subscribirnos para recibir todos los valores que se vayan publicando. Al subscribirnos, activamos que el publisher pueda publicar valores.
// isfinished -> se llama solo una vez, cuando recibamos todos los valores
// value -> se llama tantas veces como valores vayamos a recibir

// sink y assign son metodos que retornan un any cancelable
// anycancellable cancelan la subcripcion antes de que se haya acabado para ahorrar recursos
