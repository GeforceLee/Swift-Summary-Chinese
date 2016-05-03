//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let (x, y) = (1, 2)

//可以用“+”连接两个字符串
let string = "hello, " + "world"


//空的联合操作是(a ? b : c)但是对于可选的类型可以用下面的方法
var optional: String? //当前是nil

// optional = "Some Value" // 取消注释或者注释 注意下面的值的变化
var value = optional ?? "Value when `optional` is nil"

// 上面的情况相当于下面的代码
// if optional != nil {
// 	value = optional! // 拆包得到值
// } else {
//  	value = "Value when `optional` is nil"
// }

//范围的操作
for index in 1...5 {
    //迭代5次
}

var array = [1,2,3]

for index in 0..<array.count{
    //迭代 (array.count - 1) 次
}

