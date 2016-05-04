//: Playground - noun: a place where people can play

import Cocoa

//数组和字典类型可以通过var或者let声明可变还是不可变的

//数组

var shoppingList:[String] = ["Eggs","Pigs"]
shoppingList = ["Eggs","Pigs"] //是一样的

if shoppingList.isEmpty { //检测shoppingList是否是空数组
    print("The shopping list is empty")
}else {
    print("The shopping list is not empty")
}


shoppingList.append("Cow") //在数组末尾增加一个元素
shoppingList += ["Bird","Shark"]

shoppingList[1...3] = ["Bananas","Apples","Strawberries"] //一次可以替换多个元素

print(shoppingList)

shoppingList.insert("Maple Syrup", atIndex: 0) //在指定位置添加一个元素

let mapleSyrup = shoppingList.removeAtIndex(0) //删除指定位置的元素并返回

var emptyArray = [Int]() //初始化一个空数组
emptyArray = [] //同样有效

var array = [Int](count:3,repeatedValue:0) //初始化一个3个0的数组

var compoundArray = array + emptyArray


//字典

var airports:[String:String] = ["JFK":"John F. Kennedy", "SCL": "Arturo Merino Benitez"]
airports = ["JFK": "John F. Kennedy", "SCL": "Arturo Merino Benitez"] //同样有效

airports["JFK"] = "New York" //更新值

airports.updateValue("Los Angeles", forKey: "LAX") //更新或者创建值，返回是一个可选的之前值

airports["LAX"] = nil
airports.removeValueForKey("LAX") //以上两个都是删除key value

if let airportName = airports["DUB"] { //使用key过的value 返回可选值
    print("飞机场的名字是 \(airportName)")
}else {
    print("没有这个飞机场")
}


//迭代整个字典

for (airportCode,airportName) in airports {
    print("\(airportCode):\(airportName)")
}


//迭代所有的key
for airportCode in airports.keys {
    print("Airport code:\(airportCode)")
}

//迭代所有的Value
for airportName in airports.values {
    print("Airport name:\(airportName)")
}

//空字典定义
var numbers = [Int:String]()
numbers = [:]  //都可以

numbers[16] = "sixteen"


//注意
//你可以定义满足Swift的标准库哈希表协议的字典key的类型
//类型必须能通过调用hashValue的方法得到一个Int的值，同时也必须实现“is equal”方法或者“==”
//不同的程序或者相同的程序不同的执行不要求返回相同的hashValue

//所有的Swift的基础类型(像String，Int，Double，Bool) 默认都是可hash的



