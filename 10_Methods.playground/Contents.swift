//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Point {
    var x = 0.0,y=0.0
    static var xy = 0.9
    
    
    //mutating 可以修改本身
    mutating func moveByX(deltaX:Double, deltaY:Double){
        x += deltaX
        y += deltaY
        
        self = Point(x: x, y: y)
    }
    
    //struct的静态方法
    static func unlockLevel(level:Double) {
        if xy > level {
            xy = level
        }
    }
    
}

class Test {
    var count = 0
    
    //实例方法
    func increment(){
        count += 1
    }
    
    //类方法
    class func someTypeMethod(){
        print("Class method")
    }
}
