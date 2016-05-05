//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func test(){
    
    sayHello("Li")
    
    minMax([])
    
    
    join(string: "Hello", toString: "World",withJoiner: "New")
    join(string: "", toString: "")
    
    arithmeticMean(4,5,6,7)
    
    var someInt = 3
    var anotherInt = 107
    swapTowInts(&someInt, b: &anotherInt)
    
    
    
    printMathResult(mathFunc, a: 1, b: 2)
    
    
    let aFunc = chooseStepFunction(true)
    
    aFunc(1)
}




//简单的方法  参数接收String类型的参数  返回一个String类型
func sayHello(personName:String) -> String {
    return "Hello \(personName)!"
}


//返回一个可选的元组
func minMax(array:[Int]) -> (min:Int,max:Int)? {
    if array.isEmpty {
        return nil
    }
    return (0,1)
}

//注意：返回时void 是返回一个空的元组


//这个方法用到了外部和内部变量名称
//最后一个参数用了默认值，你可以在调用的时候不传相应的参数
//外部的名字会自动的加在参数前面，方便理解
func join(string s1:String,toString s2:String,withJoiner joiner:String = " ") -> String {
    return s1 + joiner + s2
}

//一个可变的参数可以接收多个相同类型的参数
func arithmeticMean(numbers:Double...) -> Double {
    var total:Double = 0
    for number in numbers {
        total += number
    }
    
    return total / Double(numbers.count)
}

//关键字inout的定义 可以在函数内修改参数本身的值，传进函数的变量的值同时也会更改
func swapTowInts(inout a:Int,inout b:Int)  {
    let temporaryA = a
    a = b
    b = temporaryA
}

//你也可以把一个函数作为函数参数传入函数
func printMathResult(mathFunction:(Int,Int)->Int,a:Int,b:Int)  {
    print("Result: \(mathFunction(a,b))")
}

func mathFunc(a:Int,b:Int) -> Int {
    return a+b
}



//你也可把一个函数作为函数的返回结果
func chooseStepFunction(backwards:Bool) -> (Int)-> Int {
    func stepForward(input:Int) ->Int {return input+1}
    func stepBackward(input:Int) ->Int {return input-1}
    return backwards ? stepBackward:stepForward
}


test()
