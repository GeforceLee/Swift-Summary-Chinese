//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
 在Swift中类和结构体有很多相同的
 * 定义属性存储数据
 * 定义函数提供功能
 * 定义下标，通过下标语法获得对应的的值
 * 定义初始化方法来初始状态
 * 通过默认的实现来扩展一些功能
 * 通过协议来实现一些标准的功能
 
 
 类比结构体多的一些功能:
 * 类可以继承另一个类从而获得的一些功能
 * 在运行时类型转换可以检测和推断一个类的类型
 * 在类的析构函数可以释放资源等
 * 引用计数可以使不止一个引用这个实例
 

 
 注意
 结构体在传递的时候是拷贝过程，而不是引用的，和枚举类似
 
 
 
  在类和结构体之间选择
 
 你可以通过类和结构体在代码中自定义数据
 
 然而结构体通常是通过值传递，类是通过引用传递。这说明他们使用不同的任务。这就需要你在项目中考虑解构和功能了，然后确定哪个更适合。
 
 一般的参考，如果选择结构体需要满足:
 
 * 目的是为了存储相对简单的数据
 * 需要值传递代替引用传递的
 * 结构体属性存储的值类型需要使用值传递
 * 结构体不需要从其他类型继承属性和行为

 
 
 一些合适结构体的例子
 * 几何形状，属性是Double类型的长和宽
 * 一个3D坐标，属性是Double类型的x,y,z
 
 其他的情况，定义一个类，通过实例化一个类，控制和传递都是引用。一般的选择类而不是结构体
 
 
 字符串，数组，字典的分配和拷贝
 
 Swift的字符串，数组，字典类型是作为结构体实现的，这意味着字符串，数组，字典类型分配到常量和变量或者函数传递是通过拷贝的。
 
 这些特性是不同于NSString, NSArray和NSDictionary 。因为NSString, NSArray, and NSDictionary in Foundation是类实现的

 */

struct Resolution {
    var width = 0
    var height = 0
}

class test: NSObject {
    var resolution  = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
}

