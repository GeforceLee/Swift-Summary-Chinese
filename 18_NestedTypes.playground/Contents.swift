//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
 枚举类型常被用于实现特定类或结构体的功能。也能够在有多种变量类型的环境中，方便地定义通用类或结构体来使用，为了实现这种功能，Swift允许你定义嵌套类型，可以在枚举类型、类和结构体中定义支持嵌套的类型。
 
 要在一个类型中嵌套另一个类型，将需要嵌套的类型的定义写在被嵌套类型的区域{}内，而且可以根据需要定义多级嵌套。
 */


//嵌套类型实例
/*下面这个例子定义了一个结构体BlackjackCard(二十一点)，用来模拟BlackjackCard中的扑克牌点数。BlackjackCard结构体包含2个嵌套定义的枚举类型Suit 和 Rank。
 
 在BlackjackCard规则中，Ace牌可以表示1或者11，Ace牌的这一特征用一个嵌套在枚举型Rank的结构体Values来表示。*/

struct BlackjackCard {
    enum Suit: Character {
        case Spades = "♠️",Hearts = "❤️",Diamonds = "♦️", Clubs = "♣️"
    }
    
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct  Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
        
    }
    
    
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
            output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
    
    
    
    
    
}

let  theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)

print("theAceOfSpades: \(theAceOfSpades.description)")



/*
 嵌套类型的引用
 
 在外部对嵌套类型的引用，以被嵌套类型的名字为前缀，加上所要引用的属性名：
 */

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue;
print(heartsSymbol)