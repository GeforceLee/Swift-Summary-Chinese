//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
 协议(Protocol)用于定义完成某项任务或功能所必须的方法和属性，协议实际上并不提供这些功能或任务的具体实现(Implementation)--而只用来描述这些实现应该是什么样的。类，结构体，枚举通过提供协议所要求的方法，属性的具体实现来采用(adopt)协议。任意能够满足协议要求的类型被称为协议的遵循者。
 
 协议可以要求其遵循者提供特定的实例属性，实例方法，类方法，操作符或下标脚本等。
 */


//协议的语法

//协议的定义方式与类，结构体，枚举的定义都非常相似，如下所示:

//protocol SomeProtocol {
    
//}
//protocol AnotherProtocol {
    
//}
//在类型名称后加上协议名称，中间以冒号:分隔即可实现协议；实现多个协议时，各协议之间用逗号,分隔，如下所示:

//struct SomeStructure: SomeProtocol, AnotherProtocol {
    
//}

/*
 对属性的规定
 
 协议可以规定其遵循者提供特定名称与类型的实例属性(instance property)或类属性(type property)，而不管其是存储型属性(stored property)还是计算型属性(calculate property)。此外也可以指定属性是只读的还是可读写的。
 
 如果协议要求属性是可读写的，那么这个属性不能是常量存储型属性或只读计算型属性；如果协议要求属性是只读的(gettable)，那么计算型属性或存储型属性都能满足协议对属性的规定，在你的代码中，即使为只读属性实现了写方法(settable)也依然有效。
 
 协议中的属性经常被加以var前缀声明其为变量属性，在声明后加上{ set get }来表示属性是可读写的，只读的属性则写作{ get }，如下所示:
 */
protocol SomeProtocol {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int {get}
    
}

//如下所示，这是一个含有一个实例属性要求的协议:

protocol FullyNamed {
    var fullName: String {get}
}


struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John")


/*
 这个例子中定义了一个叫做Person的结构体，用来表示具有指定名字的人。从第一行代码中可以看出，它采用了FullyNamed协议。
 
 Person结构体的每一个实例都有一个叫做fullName，String类型的存储型属性，这正好匹配了FullyNamed协议的要求，也就意味着，Person结构体完整的遵循了协议。(如果协议要求未被完全满足,在编译时会报错)
 */

//这有一个更为复杂的类，它采用并实现了FullyNamed协议，如下所示:
class Starship: FullyNamed {
    var perfix: String?
    var name: String
    init(name: String, perfix: String? = nil) {
        self.name = name
        self.perfix = perfix
    }
    
    var fullName: String {
        return (perfix != nil ? perfix! + "  " : " ") + name
    }
    
}

var nnc1701 = Starship(name: "Enterprise", perfix: "USS")
print(nnc1701.fullName)



/*Starship类把fullName属性实现为只读的计算型属性。每一个Starship类的实例都有一个名为name的必备属性和一个名为prefix的可选属性。 当prefix存在时，将prefix插入到name之前来为Starship构建fullName，prefix不存在时，则将直接用name构建fullName*/


//对方法的规定
/*
 协议可以要求其遵循者实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通的方法一样清晰的放在协议的定义中，而不需要大括号和方法体。
 
 注意： 协议中的方法支持变长参数(variadic parameter)，不支持参数默认值(default value)。
 */
protocol AProtocol {
    static func someTypeMethod()
}

//如下所示，定义了含有一个实例方法的的协议。

protocol RandomNumberGenerator {
    func random() -> Double
}

//RandomNumberGenerator协议要求其遵循者必须拥有一个名为random， 返回值类型为Double的实例方法。 (尽管这里并未指明，但是我们假设返回值在[0，1]区间内)。


//RandomNumberGenerator协议并不在意每一个随机数是怎样生成的，它只强调这里有一个随机数生成器。

//如下所示，下边的是一个遵循了RandomNumberGenerator协议的类。该类实现了一个叫做线性同余生成器(linear congruential generator)的伪随机数算法。


class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")

print("And another one: \(generator.random())")

//对突变方法的规定

//注意: 用类实现协议中的mutating方法时，不用写mutating关键字;用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。
protocol Togglable {
    mutating func toggle()
    
}

class OnOffSwitchClass: Togglable {
    func toggle() {
        
    }
}

enum OnOffSwitch : Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}


var ligihtSwitch = OnOffSwitch.Off
ligihtSwitch.toggle()


//对构造器的规定

//protocol SomeProtocol {
    //init(someParameter: Int)
//}

/*协议构造器规定在类中的实现

你可以在遵循该协议的类中实现构造器，并指定其为类的特定构造器或者便捷构造器。在这两种情况下，你都必须给构造器实现标上"required"修饰符：*/

//class SomeClass: SomeProtocol {
    //required init(someParameter: Int){
        
    //}
//}

/*
 使用required修饰符可以保证：所有的遵循该协议的子类，同样能为构造器规定提供一个显式的实现或继承实现。
 
 关于required构造器的更多内容，请参考required构造器
 
 注意
 
 如果类已经被“final”修饰符所标示，你就不需要在协议构造器规定的实现中使用"required"修饰符。因为final类不能有子类。关于final修饰符的更多内容，请参见防止重写
 */


protocol SomeOneProtocol {
    init()
}

class SomeSuperClass{
    init(){
        
    }
}

class SomeSubClass: SomeSuperClass,SomeOneProtocol {
    required override  init(){
        
    }
}

/*
 可失败构造器的规定
 
 可以通过给协议Protocols中添加可失败构造器来使遵循该协议的类型必须实现该可失败构造器。
 
 如果在协议中定义一个可失败构造器，则在遵顼该协议的类型中必须添加同名同参数的可失败构造器或非可失败构造器。 如果在协议中定义一个非可失败构造器，则在遵循该协议的类型中必须添加同名同参数的非可失败构造器或隐式解析类型的可失败构造器（init!）。
 */



//协议类型

/*
 尽管协议本身并不实现任何功能，但是协议可以被当做类型来使用。
 
 使用场景:
 
 协议类型作为函数、方法或构造器中的参数类型或返回值类型
 协议类型作为常量、变量或属性的类型
 协议类型作为数组、字典或其他容器中的元素类型
 注意: 协议是一种类型，因此协议类型的名称应与其他类型(Int，Double，String)的写法相同，使用驼峰式写法
 如下所示，这个示例中将协议当做类型来使用
 */

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

/*
 例子中又一个Dice类，用来代表桌游中的拥有N个面的骰子。Dice的实例含有sides和generator两个属性，前者是整型，用来表示骰子有几个面，后者为骰子提供一个随机数生成器。
 
 generator属性的类型为RandomNumberGenerator，因此任何遵循了RandomNumberGenerator协议的类型的实例都可以赋值给generator，除此之外，无其他要求。
 
 Dice类中也有一个构造器(initializer)，用来进行初始化操作。构造器中含有一个名为generator，类型为RandomNumberGe\
 rator的形参。在调用构造方法时创建Dice的实例时，可以传入任何遵循RandomNumberGenerator协议的实例给generator。
 
 Dice类也提供了一个名为roll的实例方法用来模拟骰子的面值。它先使用generator的random方法来创建一个[0-1]区间内的随机数种子，然后加工这个随机数种子生成骰子的面值。generator被认为是遵循了RandomNumberGenerator的类型，因而保证了random方法可以被调用。
 
 如下所示，这里展示了如何使用LinearCongruentialGenerator的实例作为随机数生成器创建一个六面骰子:
 */

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


//委托(代理)模式

/*
 委托是一种设计模式(译者注: 想起了那年 UITableViewDelegate 中的奔跑，那是我逝去的Objective-C。。。)，它允许类或结构体将一些需要它们负责的功能交由(委托)给其他的类型的实例。
 委托模式的实现很简单: 定义协议来封装那些需要被委托的函数和方法， 使其遵循者拥有这些被委托的函数和方法。
委托模式可以用来响应特定的动作或接收外部数据源提供的数据，而无需要知道外部数据源的所属类型(译者注:只要求外部数据源遵循某协议)

 */
//下文是两个基于骰子游戏的协议:

protocol DiceGame {
    var dice: Dice {get}
    func paly()
}



protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

//DiceGame协议可以在任意含有骰子的游戏中实现，DiceGameDelegate协议可以用来追踪DiceGame的游戏过程

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6,generator: LinearCongruentialGenerator())
    var square = 0
    var  board: [Int]
    init(){
        board =  [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    func paly() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

/*
 这个版本的游戏封装到了SnakesAndLadders类中，该类采用了DiceGame协议，并且提供了dice属性和play实例方法用来遵循协议。(dice属性在构造之后就不在改变，且协议只要求dice为只读的，因此将dice声明为常量属性。)
 
 在SnakesAndLadders类的构造器(initializer)初始化游戏。所有的游戏逻辑被转移到了play方法中，play方法使用协议规定的dice属性提供骰子摇出的值。
 
 注意:delegate并不是游戏的必备条件，因此delegate被定义为遵循DiceGameDelegate协议的可选属性，delegate使用nil作为初始值。
 DicegameDelegate协议提供了三个方法用来追踪游戏过程。被放置于游戏的逻辑中，即play()方法内。分别在游戏开始时，新一轮开始时，游戏结束时被调用。
 
 因为delegate是一个遵循DiceGameDelegate的可选属性，因此在play()方法中使用了可选链来调用委托方法。 若delegate属性为nil， 则delegate所调用的方法失效。若delegate不为nil，则方法能够被调用
 */

//如下所示，DiceGameTracker遵循了DiceGameDelegate协议

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Start a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice ")
        
        
    }
    
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
    
}

/*
 DiceGameTracker实现了DiceGameDelegate协议规定的三个方法，用来记录游戏已经进行的轮数。 当游戏开始时，numberOfTurns属性被赋值为0; 在每新一轮中递加; 游戏结束后，输出打印游戏的总轮数。
 
 gameDidStart方法从game参数获取游戏信息并输出。game在方法中被当做DiceGame类型而不是SnakeAndLadders类型，所以方法中只能访问DiceGame协议中的成员。当然了，这些方法也可以在类型转换之后调用。在上例代码中，通过is操作符检查game是否为 SnakesAndLadders类型的实例，如果是，则打印出相应的内容。
 
 无论当前进行的是何种游戏，game都遵循DiceGame协议以确保game含有dice属性，因此在gameDidStart方法中可以通过传入的game参数来访问dice属性，进而打印出dice的sides属性的值。
 */

//DiceGameTracker的运行情况，如下所示:
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.paly()

//在扩展中添加协议成员
/*
 即便无法修改源代码，依然可以通过扩展(Extension)来扩充已存在类型(译者注: 类，结构体，枚举等)。扩展可以为已存在的类型添加属性，方法，下标脚本，协议等成员。
 注意: 通过扩展为已存在的类型遵循协议时，该类型的所有实例也会随之添加协议中的方法
 TextRepresentable协议含有一个asText，如下所示：
 */

protocol TextRepresentable {
    func asText() -> String
}

//通过扩展为上面提到的Dice类遵循TextRepresentable协议
extension Dice: TextRepresentable {
    func asText() -> String{
        return "A \(sides) -sided dice"
    }
}
//从现在起，Dice类型的实例可被当作TextRepresentable类型：
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.asText())

//SnakesAndLadders类也可以通过扩展的方式来遵循协议：
extension SnakesAndLadders: TextRepresentable {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.asText())


//通过扩展补充协议声明
//当一个类型已经实现了协议中的所有要求，却没有声明时，可以通过扩展来补充协议声明:

struct Hamster {
    var name: String
    func  asText() -> String {
        return "A hamster named \(name)"
    }
}


extension Hamster: TextRepresentable{}

//从现在起，Hamster的实例可以作为TextRepresentable类型使用
let simonTheHamster = Hamster(name: "Simon")
let somthingTextRepresentable: TextRepresentable = simonTheHamster
print(somthingTextRepresentable.asText())
//注意: 即使满足了协议的所有要求，类型也不会自动转变，因此你必须为它做出明显的协议声明

//集合中的协议类型
//协议类型可以被集合使用，表示集合中的元素均为协议类型:

let things: [TextRepresentable] = [game,d12,simonTheHamster]

//如下所示，things数组可以被直接遍历，并调用其中元素的asText()函数:
for thing in things {
    print(thing.asText())
}
//thing被当做是TextRepresentable类型而不是Dice，DiceGame，Hamster等类型。因此能且仅能调用asText方法

//协议的继承
//协议能够继承一到多个其他协议。语法与类的继承相似，多个协议间用逗号，分隔

protocol InheritingProtocol: SomeProtocol, AProtocol {
    
}
//如下所示，PrettyTextRepresentable协议继承了TextRepresentable协议
protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}

//遵循PrettyTextRepresentable协议的同时，也需要遵循TextRepresentable协议。

//如下所示，用扩展为SnakesAndLadders遵循PrettyTextRepresentable协议:

extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "⬆️ "
            case let snake where snake < 0:
                output += "⬇️ "
            default:
                output += "O "
            }
        }
        return output
    }
}

/*
 在for in中迭代出了board数组中的每一个元素:
 
 当从数组中迭代出的元素的值大于0时，用▲表示
 当从数组中迭代出的元素的值小于0时，用▼表示
 当从数组中迭代出的元素的值等于0时，用○表示
 */
//任意SankesAndLadders的实例都可以使用asPrettyText()方法。

print(game.asPrettyText())

//类专属协议
//你可以在协议的继承列表中,通过添加“class”关键字,限制协议只能适配到类（class）类型。（结构体或枚举不能遵循该协议）。该“class”关键字必须是第一个出现在协议的继承列表中，其后，才是其他继承协议。


protocol SomClassOnlyProtocol: class,InheritingProtocol {
    // class-only protocol definition goes here
}

//在以上例子中，协议SomeClassOnlyProtocol只能被类（class）类型适配。如果尝试让结构体或枚举类型适配该协议，则会出现编译错误。

/*
 注意
 
 当协议需求定义的行为，要求（或假设）它的遵循类型必须是引用语义而非值语义时，应该采用类专属协议。
 */

//协议合成
//一个协议可由多个协议采用protocol<SomeProtocol， AnotherProtocol>这样的格式进行组合，称为协议合成(protocol composition)。

protocol Named {
    var name: String {get}
}

protocol Aged {
    var age:Int {get}
}


struct APerson: Named,Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named,Aged>)  {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayPerson = APerson(name:"Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)

/*
 Named协议包含String类型的name属性;Aged协议包含Int类型的age属性。Person结构体遵循了这两个协议。
 
 wishHappyBirthday函数的形参celebrator的类型为protocol<Named，Aged>。可以传入任意遵循这两个协议的类型的实例
 
 注意: 协议合成并不会生成一个新协议类型，而是将多个协议合成为一个临时的协议，超出范围后立即失效。
 */


//检验协议的一致性
//使用is和as操作符来检查协议的一致性或转化协议类型。
/*
 is操作符用来检查实例是否遵循了某个协议。
 as?返回一个可选值，当实例遵循协议时，返回该协议类型;否则返回nil
 as用以强制向下转型。
 */
@objc protocol HasArea {
    var area: Double {get}
}

//注意: @objc用来表示协议是可选的，也可以用来表示暴露给Objective-C的代码，此外，@objc型协议只对类有效，因此只能在类中检查协议的一致性。

//如下所示，定义了Circle和Country类，它们都遵循了HasArea协议

class Circle: HasArea {
    let pi = 3.14
    var radius: Double
    @objc var area: Double { return pi * radius * radius}
    init(radius: Double) {self.radius = radius}
}


class Country: HasArea {
    @objc var area: Double
    init(area: Double) {self.area = area}
}

//Circle类把area实现为基于存储型属性radius的计算型属性，Country类则把area实现为存储型属性。这两个类都遵循了HasArea协议。

//如下所示，Animal是一个没有实现HasArea协议的类

class Animal {
    var legs: Int
    init(legs: Int) {self.legs = legs}
}

//Circle，Country，Animal并没有一个相同的基类，因而采用AnyObject类型的数组来装载在他们的实例，如下所示:

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 2222),
    Animal(legs: 4)
]

//objects数组使用字面量初始化，数组包含一个radius为2。0的Circle的实例，一个保存了英国面积的Country实例和一个legs为4的Animal实例。

//如下所示，objects数组可以被迭代，对迭代出的每一个元素进行检查，看它是否遵循了HasArea协议:

for object in objects {
    if let objectWithArea = object as? HasArea {
       print("Area is \(objectWithArea.area)")
    }else {
        print("Somthing that doesn't have an area")
    }
}

/*
 当迭代出的元素遵循HasArea协议时，通过as?操作符将其可选绑定(optional binding)到objectWithArea常量上。objectWithArea是HasArea协议类型的实例，因此area属性是可以被访问和打印的。
 
 objects数组中元素的类型并不会因为向下转型而改变，它们仍然是Circle，Country，Animal类型。然而，当它们被赋值给objectWithArea常量时，则只被视为HasArea类型，因此只有area属性能够被访问。
 */

//对可选协议的规定
//可选协议含有可选成员，其遵循者可以选择是否实现这些成员。在协议中使用@optional关键字作为前缀来定义可选成员。

//像someOptionalMethod?(someArgument)这样，你可以在可选方法名称后加上?来检查该方法是否被实现。可选方法和可选属性都会返回一个可选值(optional value)，当其不可访问时，?之后语句不会执行，并整体返回nil
//注意: 可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循
//如下所示，Counter类使用含有两个可选成员的CounterDataSource协议类型的外部数据源来提供增量值(increment amount)
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int {get}
}

//CounterDataSource含有incrementForCount的可选方法和fiexdIncrement的可选属性，它们使用了不同的方法来从数据源中获取合适的增量值。
//注意: CounterDataSource中的属性和方法都是可选的，因此可以在类中声明但不实现这些成员，尽管技术上允许这样做，不过最好不要这样写。

//Counter类含有CounterDataSource?类型的可选属性dataSource，如下所示:

class Counter {
    var count = 0
    var dataSoucrce: CounterDataSource?
    func increment() -> Void {
        if let amount = dataSoucrce?.incrementForCount?(count) {
            count += amount
        }else if let amount = dataSoucrce?.fixedIncrement {
            count += amount
        }
    }
}
/*
 count属性用于存储当前的值，increment方法用来为count赋值。
 
 increment方法通过可选链，尝试从两种可选成员中获取count。
 
 由于dataSource可能为nil，因此在dataSource后边加上了?标记来表明只在dataSource非空时才去调用incrementForCount方法。
 
 即使dataSource存在，但是也无法保证其是否实现了incrementForCount方法，因此在incrementForCount方法后边也加有?标记
 
 在调用incrementForCount方法后，Int型可选值通过可选绑定(optional binding)自动拆包并赋值给常量amount。
 
 当incrementForCount不能被调用时，尝试使用可选属性fixedIncrement来代替。
 */

//ThreeSource实现了CounterDataSource协议，如下所示:
class ThreeSource: CounterDataSource {
    @objc let fixedIncrement: Int = 3
}

//使用ThreeSource作为数据源开实例化一个Counter:
var counter = Counter()
counter.dataSoucrce = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
//TowardsZeroSource实现了CounterDataSource协议中的incrementForCount方法，如下所示:
class TowardZeroSource: CounterDataSource {
    @objc func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        }else {
            return -1
        }
    }
}


counter.count  = -4
counter.dataSoucrce = TowardZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}


