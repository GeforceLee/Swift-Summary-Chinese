//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//for循环中定义了index  执行了5次
for index in 1...5 {
    print("Index is \(index)")
}

//我们不关心值可以用"_"  调用了5次
for _ in 1..<6 {
    print("No value")
}


//用元组
let dictionary = ["one":1,"two":2,"three":3]
for (numberName,numberValue) in dictionary {
    print("\(numberName) is \(numberValue)")
}

//字符串的
var char = "e"
for char in "Yes".characters {
    print("\(char)")
}

//Switches

//不在需要break 但是每个case 必须要有些代码
let someChar = "e"
switch someChar{
    case "a","e","i","o","u":
        print("\(someChar) is a vowel" )
    default:
        print("\(someChar) is a consonant")
}

//还可以是一个范围匹配
let count = 3_000_000_000_000
let countedThings = "stars"

switch count {
case 0...9:
    print("a few")
case 10...10_000:
    print("many")
default:
    print("a lot of")
}

//使用元组
let coord = (1,1)

switch coord {
case (0,0):
    print("Origin")
case (_,0):
    print("X axis")
case (0,_):
    print("Y axis")
case (-2...2,-3...3):
    print("within boundries")
default:
    print("out of bounds")
}

//值绑定：在case里通过一个临时变量赋值
let anotherPoint = (0,0)
switch anotherPoint {
case (let x,0):
    print(("on the x-axis with an x value of \(x)"))
case (0,let y):
    print("on the y-axis with a y value of \(y)")
case let(z,w): //这个case扮演者default，因为z,w可以是任何值
    print("somewhere else at \(z),\(w)")
}

switch anotherPoint {
case let(x,y) where x==y:
    print("x = y")
default:
    break
}


//fallthrough 强制switch 会进入default case
switch anotherPoint {
case let(x,y) where x == y:
    print("x = y")
    fallthrough
default:
    print("are equal")
}


//可以用continue和break 跳转到对应的标签
master:while true {
    loop: for rats in 1...5 {
        print(rats)
        break master
    }
}
