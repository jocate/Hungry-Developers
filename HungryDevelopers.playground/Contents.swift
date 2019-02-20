import UIKit

class Spoon {
    
    private let spoonLock = NSLock()
    
    var index: Int
    
    init(index: Int) {
        self.index = index
    }
    
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
        if leftSpoon.index > rightSpoon.index {
            rightSpoon.pickUp()
            leftSpoon.pickUp()
            
        } else {
            leftSpoon.pickUp()
            rightSpoon.pickUp()
        }
        // pick up both spoons before returning
    }
    
    func eat() {
        usleep(200)
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

var spoon1 = Spoon(index: 1)
var spoon2 = Spoon(index: 2)
var spoon3 = Spoon(index: 3)
var spoon4 = Spoon(index: 4)
var spoon5 = Spoon(index: 5)

let developer = Developer(leftSpoon: spoon2, rightSpoon: spoon1)
let developer2 = Developer(leftSpoon: spoon1, rightSpoon: spoon3)
let developer3 = Developer(leftSpoon: spoon3, rightSpoon: spoon4)
let developer4 = Developer(leftSpoon: spoon4, rightSpoon: spoon5)
let developer5 = Developer(leftSpoon: spoon5, rightSpoon: spoon2)

var developers: [Developer] = [developer, developer2, developer3, developer4, developer5]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
