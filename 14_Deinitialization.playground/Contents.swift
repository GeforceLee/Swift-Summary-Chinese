//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*析构方法只在类中存才
 析构方法会自动的在类呗释放前调用。
 同时析构方法不允许自己调用
 父类的析构方法被子类集成，同时父类的析构方法会自动在子类析构函数执行后执行
 即使子类没有提供自己的析构方法，父类的析构方法会自动调用
*/

class Bank {
    static var coinsInBank = 10_000
    
    static func vendCoins(numberOfCoinsToVend: Int) -> Int {
        let numOfCoins =  min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numOfCoins
        return numOfCoins
    }
    
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
    
}


class People {
    deinit{
        print("Poeple deinit")
    }
}

class Player: People {
    var coinsInPurse: Int
    
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    
    func winCoins(coins: Int) -> Void {
        coinsInPurse += Bank.vendCoins(coins)
    }
    
    deinit {
        Bank.receiveCoins(coinsInPurse)
        print("Player deinit")
    }
}

//这使用了一个可选的，因为当变量赋新值的时候原值会被释放
var playerOne:Player? = Player(coins: 100)

playerOne = nil

