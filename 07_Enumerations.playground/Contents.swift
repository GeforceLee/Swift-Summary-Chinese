//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//定义一个枚举
//在这个枚举中每个成员没有默认的值
enum CompassPoint {
    case North
    case South
    case East
    case West
}

//定义一个每个成员都有指定类型的枚举
enum Barcode {
    case UPCA(Int,Int,Int,Int)
    case QRCode(String)
}

//下面的枚举每定义成一个原始值，元素必须唯一的
enum ASCIIControlCharacter:Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

func test() {
    var someEnum = CompassPoint.East
    
    //一旦类型知道了，可以省去前面的类型直接"."
    someEnum = .West
    
    print("This is the enum:\(someEnum)")
    someEnum == .West ? print("Equal") : print("Not Equal")
    
    var newEnum = Barcode.QRCode("123456")
    newEnum = .QRCode("654321")
    
    print("enum is \(newEnum)")
    
    let asciiCode = ASCIIControlCharacter.Tab
    print("code is \(asciiCode.rawValue)")
    
    //下面的情况不能保证有对应的枚举，所有返回的是一个可选值
    if let lineFeed = ASCIIControlCharacter(rawValue: "\r"){
        print(lineFeed)
    }
}

test()


