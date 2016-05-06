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
    
    
    func doSOmething() -> Void {
        
    }
    
    
    init(){
        print("DataImporter init")
    }
    
}


class Test {
    //这是一个能存储数据的属性，提供了一个默认值，也可以在其他地方赋值
    var prop = "hello"
    
    //这是一个属性的set get   可以实时计算等操作。
    //不能直接在set里用self.someCalculation = newValue  这样会导致循环调用 程序crash 
    //所以引用了以个_someCalculation
    var _someCalculation:Int
    var someCalculation:Int {
        get {
            return 1+1
        }
        
        set {
            self.someCalculation = newValue
            self._someCalculation = newValue
        }
    
    }
    
    
    //willSet是在设置新值之前调用的，可以用来检测数据是否合法等操作。
    //didSet是在设置新值之后调用的
    var propWithObserver:Int = 0 {
        willSet{
            print(newValue)
        }
        didSet{
            print(oldValue)
        }
    }
    //只读 属性
    var someFixedCalculatedProperty:Double {
        return 3*3
    }
    
    //注意这“class”关键字，说明这是一个静态变量 static用在struct中  class用在类中  （这有别于OC）
    class var computedTypeProperty: Int {
        get {
            return 1+1
        }
        
        set {
            //do set
            
        }
    }
    
    
    //懒惰存储属性是当它第一次被使用时才进行初值计算
    /**注意
    必须声明懒惰存储属性为变量属性（通过var），因为它的初始值直到实例初始化完成之后才被检索。常量属性在实例初始化完成之前就应该被赋值，因此常量属性不能够被声明为懒惰存储属性。
    
    当属性初始值因为外部原因，在实例初始化完成之前不能够确定时，就要定义成懒惰存储属性。当属性初始值需要复杂或高代价的设置，在它需要时才被赋值时，懒惰存储属性就派上用场了。**/
    lazy var importer = DataImporter()
    
    var im2 = DataImporter()
    init(sc:Int)  {
        _someCalculation = sc
        
        //var rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
        
        //rangeOfFourItems.firstValue = 6
        
        
    }
    
}


var test = Test(sc:2)
print("分界线")
print(test.importer.fileName)
