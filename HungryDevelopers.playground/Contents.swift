import UIKit

class Spoon {
    
    private let spoonLock = NSLock()
    
    func pickUp() {
        spoonLock.lock()
        
    }
    
    func putDown() {
        spoonLock.unlock()
    }
}

class Developer {
    
    
    let leftSpoon: Spoon
    let rightSpoon: Spoon
    
    init(leftSpoon: Spoon, rightSpoon: Spoon) {
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    func think() {
        leftSpoon.pickUp()
        rightSpoon.pickUp()
        // pick up both spoons before returning
    }
    
    func eat() {
        print("about to eat")
        usleep(200)
        print("eating")
        leftSpoon.putDown()
        rightSpoon.putDown()
        // pause for random amount of time before putting both spoons down usleep()
    }
    
    func run() {
        while true {
            think()
            eat()
        }
    }
    
 
}

var spoon1 = Spoon()
var spoon2 = Spoon()
var spoon3 = Spoon()
var spoon4 = Spoon()
var spoon5 = Spoon()

let developer = Developer(leftSpoon: spoon2, rightSpoon: spoon1)
let developer2 = Developer(leftSpoon: spoon1, rightSpoon: spoon3)
let developer3 = Developer(leftSpoon: spoon3, rightSpoon: spoon4)
let developer4 = Developer(leftSpoon: spoon4, rightSpoon: spoon5)
let developer5 = Developer(leftSpoon: spoon5, rightSpoon: spoon2)

var developers: [Developer] = [developer, developer2, developer3, developer4, developer5]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
