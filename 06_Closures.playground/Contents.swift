//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func test() {
    
    /**内联闭包**/
    let array = ["John","Tim","Steve"]
    
    var reversed = array.sort({(s1:String,s2:String) -> Bool  in return s1>s2})
    
    //当闭包作为一个函数的参数的时候，可以使用类型推断，可以省略参数和返回的类型。
    reversed = array.sort({s1,s2 in return s1>s2})
    
    //当闭包一行就能完成时 return就可以忽略不写了，因为返回类型是可以推断出来的
    reversed = array.sort({s1,s2 in s1 > s2})
    
    
    //可以用"$+序号"表示闭包的参数
    reversed = array.sort({$0>$1})
    
    //甚至更极端的只用一个">"操作符就可以了
    reversed = array.sort(>)
    
    /**尾随闭包**/
    //闭包在内联中有时太长
    //下面展示下不用尾随闭包的代码
    someFunctionThatTakesAClosure({
        //写一些代码
    })
    
    //下面展示下尾随闭包的代码
    someFunctionThatTakesAClosure(){
        //写一些代码
    }
    
    //排序方法用尾随闭包
    array.sort(){$0>$1}
    
    //注意:如果除了尾随闭包没有其他参数 "()" 可以省略
    
    let digitNames = [
        0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]
    
    let numbers = [16,58,510]
    
    let stringsArray = numbers.map {
        (number)-> String in
        var number = number
        var output = ""
        while number>0 {
            output = digitNames[number % 10]! + output //注意：如果一定有值 可以用"!" 强制拆包
            number /= 10
        }
        return output
    }
    
    print(stringsArray)
    
    
    print(reversed)
    
    
}


func someFunctionThatTakesAClosure(closure:()->())  {
    //做些什么。。。。
}

test()