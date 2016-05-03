//: Playground - noun: a place where people can play

import UIKit


var str = "Hello, playground"
let hello = "Hello world"

//"?"是可选  可以是nil或者是数字
var optionalInteger: Int?
optionalInteger = 42

//保留字可以通过' '当做变量和常量
let `private` = "private word"
var word = `private`

//打印字符串可以通过“+” 或者\()来完成
print(hello + " " + word)
print("\(hello) \(word)")

//可以通过“_”来分割数字，使数字变得可读
var paddedInteger = 1_000_000

//要使用确定的类型进行类型转换
//对于一般类型用Int就够了
let thousand: UInt16 = 1_000
let one: UInt8 = 1
let thousandAndOne = thousand + UInt16(one)

//默认的推断是Int
let anotherNumber: Int = Int(UINT32_MAX)
let number = 6745
let result = anotherNumber + number

//可以通过typealias 方便的给类型起别名
typealias AudioResolution = UInt16
AudioResolution.min

//元组可以包含任何类型任何数量的元素
let success = (200, "Success")
typealias Success = (Int, String)
let exito: Success = success


//如果你收到一个这样格式response，你可以方便的存储像下面这样
let (code, message) = success


//如果你只需要一个值，可以这样
let (response, _) = success


//值可以通过下标来访问
success.0
success.1


//名称可以在前面定义
//可以通过名称来访问属性
let someTuple = (number: 456, assertion: "Yes")
someTuple.number
someTuple.assertion



//可选的值可有可无
let optional: Int? = 2

if optional != nil {
    "It's not nil!"
    optional!
} else {
    "It's nil"
}

//可以用可选值来赋值,如果optional是nil就不会赋值
if let value = optional {
    "It's not nil!"
    value
}else {
    "It's nil"
}


//可以用隐式拆包 下面是说明knownString永远不是nil 如果是nil 程序就会crash
//参考http://blog.csdn.net/woaifen3344/article/details/30244201
let knownString: Int! = 10
if knownString != nil {
    "It's got a value"
    knownString // No need for explicit unwrapping
}

//断言
assert(true == true, "True isn't equal to false")

