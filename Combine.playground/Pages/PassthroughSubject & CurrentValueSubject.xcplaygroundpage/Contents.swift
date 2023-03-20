import Foundation
import Combine

// Using a subject to relay values to subscribers

struct Weather {
    let weatherPublisher = PassthroughSubject<Int, Error>()
    
    func getWeatherInfo() {
        weatherPublisher.send(35)
        //weatherPublisher.send(completion: .finished)
        //weatherPublisher.send(completion: .failure(URLError(.badURL)))
        weatherPublisher.send(32)
    }
}

let weather = Weather()
weather.weatherPublisher.sink { completion in
    switch completion {
    case .failure(let error):
        print("Error \(error.localizedDescription)")
    case .finished:
        print("Finished")
    }
    //print("Completion \(completion)")
} receiveValue: { value in
    print("Value: \(value)")
}

weather.getWeatherInfo()

// Subscribing a subject to a publisher

let relay = PassthroughSubject<String, Never>()

let publisher = ["hello", "world", "!"].publisher

let subscription = relay
    .sink { value in
        print("subscription1 received value: \(value)")
}

publisher.subscribe(relay)

// Using a `CurrentValueSubject` to hold and relay the latest value to new subscribers

struct BotApp {
    var onboardingPublisher = CurrentValueSubject<String, Error>("Welcome!")
    
    func startOnboarding() {
        onboardingPublisher.send("send a message to someone")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            onboardingPublisher.send("send an sticker")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            onboardingPublisher.send("enable notifications")
        }
        
    }
}

let bot = BotApp()

let cancellable = bot.onboardingPublisher.sink { completion in
    switch completion {
    case .failure(let error):
        print("Error \(error.localizedDescription)")
    case .finished:
        print("Finished")
    }
} receiveValue: { values in
    print("Values: \(values)")
}

bot.startOnboarding()

//let cancellable = bot.onboardingPublisher.handleEvents { subscription in
//    print("1. Subscription Received: \(subscription)")
//} receiveOutput: { value in
//    print("2. Value Received: \(value)")
//} receiveCompletion: { completion in
//    print("3. Completion Received: \(completion)")
//} receiveCancel: {
//    print("4. Cancel Received")
//} receiveRequest: { request in
//    print("5. Request Received")
//}.sink { completion in
//    switch completion {
//    case .failure(let error):
//        print("Error \(error.localizedDescription)")
//    case .finished:
//        break
//        //print("Finished")
//    }
//} receiveValue: { values in
//    //print("Values: \(values)")
//}


