//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
 =================================================
 常量结构体实例存储属性
 =================================================
 
 如果创建一个结构体实例是一个常量的话，你不可以修改这个实例的属性，不管这个属性是否声明的是一个变量属性
 这个特点使结构体是一个值类型
 这与类不同，类是引用类型，如果你定义一个类是常量，你也可以修改类的属性

 */

struct FixedLengthRange {
    var firstValue:Int
    let length:Int
    
    //这定义了全局变量或者类型变量。所有的这个结构体的实例都包含这些值
    static var storedTypeProperty = "Some value"
    static var _computedTypeProperty:Int = 0
    static var computedTypeProperty:Int {
        //get方法 返回int值
        get {
            print(self._computedTypeProperty)
            return self._computedTypeProperty
        }
        set {
            self._computedTypeProperty = newValue
        }
    }
}

class DataImporter {
    
    var fileName = "data.txt"
    
    var cont:Test = Test()
    
    func doSOmething() -> Void {
        
    }
    
    
}


class Test {
    
}

var fix = FixedLengthRange(firstValue: 1, length: 10)
FixedLengthRange.computedTypeProperty = 10
print(FixedLengthRange.computedTypeProperty)
