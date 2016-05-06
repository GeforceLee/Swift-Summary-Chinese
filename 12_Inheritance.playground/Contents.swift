//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//一个类可以从另外一个类中继承方法，属性或者其它的一些特性。当一个类继承于另外一个类时，这个继承的类叫子类，被继承的类叫父类。继承是Swift中类区别于其它类型的一个基本特征。

//Swift中的类可以调用父类的方法，使用父类的属性和下标，还可以根据需要使用重写方法或者属性来重新定义和修改他们的一些特性。Swift可以帮助你检查重写的方法和父类的方法定义是相符的。

//类还可以为它继承的属性添加观察者，这样可以能够让它在一个属性变化的时候得到通知。属性观察者可以被添加给任何属性，不管它之前是存储属性还是计算属性。

//任何一个不继承于其它类的类被称作基类

//注意：Swift的类不是从一个全局基类继承而来。在你编写代码的时，只要是在类的定义中没有继承自父类的类都是基类。


//通过super调用父类的属性和方法

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    
    func makeNoise() -> Void {
        //什么都不做  不是所有交通工具都有噪音
    }
}


class Bicyle: Vehicle {
    var hasBasket = false
}


class Tandem: Bicyle {
    var currentNumberOfPassengers = 0
}

class Train: Vehicle {
    //这是重写父类的方法
    override func makeNoise() {
        print("Choo Choo")
    }
}

class Car: Vehicle {
    var gear = 1
    
    override var description: String {
        return super.description + " in gear \(gear)"
    }
    
    final func activateAirBags(){
        //子类不能重写了
    }
}


class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
    
    //override  func activateAirBags(){
        ////报错
    //}

}




let bike = Bicyle()
bike.hasBasket = true
print(bike.description)


let tandem = Tandem()
tandem.currentNumberOfPassengers = 7




