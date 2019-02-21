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
    var name: String
    
    init(leftSpoon: Spoon, rightSpoon: Spoon, name: String) {
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
        self.name = name
    }
    
    func think() {
        if leftSpoon.index > rightSpoon.index {
            print(name)
            rightSpoon.pickUp()
            leftSpoon.pickUp()
            
        } else {
            print(name)
            leftSpoon.pickUp()
            rightSpoon.pickUp()
        }
        // pick up both spoons before returning
    }
    
    func eat() {
        print("Eating: \(name)")
        usleep(2000)
        leftSpoon.putDown()
        rightSpoon.putDown()
        // pause for random amount of time before putting both spoons down usleep()
    }
    
    func run() {
        for i in 1...500 {
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

let developer = Developer(leftSpoon: spoon2, rightSpoon: spoon1, name: "Developer 1")
let developer2 = Developer(leftSpoon: spoon1, rightSpoon: spoon3, name: "Developer 2")
let developer3 = Developer(leftSpoon: spoon3, rightSpoon: spoon4, name: "Developer 3")
let developer4 = Developer(leftSpoon: spoon4, rightSpoon: spoon5, name: "Developer 4")
let developer5 = Developer(leftSpoon: spoon5, rightSpoon: spoon2, name: "Developer 5")

var developers: [Developer] = [developer, developer2, developer3, developer5, developer4]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
