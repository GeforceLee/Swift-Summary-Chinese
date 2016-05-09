//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
    
}
//实参名（Local Parameter Names）和形参名（External Parameter Names）
//fromFahrenheit就是形参 fahrenheit就是实参
//注意：如果你在构造器中没有定义形参，提供一个下横线（_）作为区分形参和上面说描述的重写默认行为。

/*
 类和结构体必须在它们被创建时把它们所有的属性设置为合理的值。存储属性不能为不确定状态
 
 你可以在构造方法里面给一个属性设置一个初始值，或者在定义的时候给属性设置一个默认值。
 注意：当你对给一个属性分配一个默认值的时候，它会调用它相对应的初始化方法，这个值是对属性直接设置的，不会通知它对应的观察者
 */

struct Other {
    var temp: Double
    var otherProp: Int = 10
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}
//结构类型有一种成员逐一完成初始化的构造器，可以在定义结构的时候直接指定每个属性的初始值。
var other = Other(temp: 0.0, otherProp: 0)
var size = Size()
var asize = Size(width: 1.0, height: 1.0)
var point = Point()
var aPoint = Point(x: 1.0, y: 1.0)

/*
 在实例的初始化过程中，构造器可以调用其他的构造器来完成初始化。这个过程叫构造器代理，可以避免多个构造器的重复代码。
 
 对于数值类型和类来说，构造器代理的工作形式是不一样的。数值类型（结构和枚举）不支持继承，因此他们的构造器代理相对简单，因为它们只能使用自己的构造器代理。但是一个类可以继承自另外一个类，所以类需要确保在初始化的时候将它所有的存储属性都设置为正确的值。这种过程在下一节类的继承和初始化中叙述。
 
 对于数值类型来说，可以使用self.init来调用其他构造器，注意只能在这个数值类型内部调用相应的构造器。
 
 需要注意的是如果你为数值类型定义了一个构造器，你就不能再使用默认构造器了。这种特性可以避免当你提供了一个特别复杂的构造器的时候，另外一个人误使用了默认构造器而出错。
 
 注意：如果你想要同时使用默认构造器和你自己设置的构造器，不要将这两种构造器写在一起，而是使用扩展形式。更多内容可以参考Extensions一章。
 */
struct Rect {
    var origin = Point()
    var size  = Size()
    
    init(){}
    
    init(origin: Point, size: Size){
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size){
        let originX = center.x - size.width/2
        let originY = center.y - size.height/2
        self.init(origin:Point(x: originX, y: originY),size: size)
    }
}


/*
 在初始化时修改静态属性
 当你在设置静态属性值时，只要在初始化完成之前，你都可以在初始化时随时修改静态属性。
 注意：对于类的实例化，一个静态属性只能在初始化时被修改，这个初始化在类定义时已经确定。
 */

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() -> Void {
        print(text)
    }
    
}


//类的初始化

//1、自定义初始化方法要先调用自己类默认初始化方法，自己重写默认初始化方法要先调用父类默认初始化方法

//2、应该要先调用父类的构造器或者自身的默认构造器，以防止先给属性赋值了然后才调用父类或者自身的默认构造器把以前的赋值覆盖了

//一个类的所有存储属性-包括从父类继承而来的属性-都必须在初始化的时候设置初始值。

//Swift为class类型定义了两种构造器来确保它们所有的存储属性都设置了初始值。这两种方式叫做指定构造器和便捷构造器。

/*
 指定构造器和便捷构造器
 
 指定构造器是一个类最主要的构造器。指定构造器通过设置所有属性的初值并且调用所有的父类构造器来根据构造链一次初始化所有的属性。
 
 类所拥有的指定构造器很少，一般只有一个，并且是连接这父类的构造链依次完成构造的。
 
 每个类至少有一个指定构造器，在有些情况下，需要使用继承来从父类中得到该指定构造器。
 
 便捷构造器是类的第二种常用构造器。你可以调用同一个类中的指定构造器来定义一个便捷构造器，使用指定构造器来设置相关的参数默认值。你还可以定义一个便捷构造器来创建这个类的实例或者是别的特殊用途。
 
 如果你的类不需要它们，也可以不定义便捷构造器。不过对于常见初始化模型需要快捷方式的时候创建一个便捷构造器可以让你的初始化过程变成十分简单便捷。
 */

/*
 构造链
 为了简化指定构造器和便捷构造器的关系，Swift为两种构造器的代理调用设置了三个规则：

 规则1
 指定构造器必须调用它直接父类的指定构造器
 
 规则2
 便捷构造器只能调用同一个类中的其它构造器
 
 规则3
 便捷构造器必须以调用一个指定构造器结束
 
 记下这些规则的简单方法是：
 指定构造器必须向上代理
 便捷构造器必须横向代理
 */

class Vehicel {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}


let vehicel = Vehicel()
print(vehicel.description)


class Bicycle: Vehicel {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

//注意
//子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
    
}


/*
 Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程能不出错地完成：
 
 安全检查 1
 
 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
 
 如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。
 
 安全检查 2
 
 指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
 
 安全检查 3
 
 便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
 
 安全检查 4
 
 构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用self作为一个值。
 
 类实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成后，该实例才会成为有效实例，才能访问属性和调用方法。
 
 以下是两段式构造过程中基于上述安全检查的构造流程展示：
 
 阶段 1
 
 某个指定构造器或便利构造器被调用。
 完成新实例内存的分配，但此时内存还没有被初始化。
 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
 指定构造器将调用父类的构造器，完成父类属性的初始化。
 这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
 当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
 阶段 2
 
 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
 最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。
 */


/*
 构造器的自动继承
 
 如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
 
 假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用：
 
 规则 1
 
 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
 
 规则 2
 
 如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。
 
 即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
 
 注意
 对于规则 2，子类可以将父类的指定构造器实现为便利构造器。
 */
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}


let oneR = RecipeIngredient()
let twoR = RecipeIngredient(name: "Bacon")
let threeR = RecipeIngredient(name: "Eggs", quantity: 6)


class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]


breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

/*
 可失败构造器
 如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器。这里所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
 
 为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面添加问号(init?)。
 */

struct Animal {
    let species: String
    init?(species: String) {
        if  species.isEmpty {
            return nil
        }
        
        self.species = species
    }
}

let someCreature = Animal(species:"Giraffe")
if let giraffe = someCreature {
    print(giraffe.species)
}


if let giraffe = Animal(species: "") {
    print(giraffe.species)
}else {
    print("init fail")
}

//枚举类型的可失败构造器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}


let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// 打印 "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}
// 打印 "This is not a defined temperature unit, so initialization failed."

//带原始值的枚举类型的可失败构造器

enum TempUnit: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fUnit = TempUnit(rawValue: "F")
if (fUnit != nil) {
    print("This is a defined temperature unit, so initialization succeeded.")
}


/*
 构造失败的传递
 
 类，结构体，枚举的可失败构造器可以横向代理到类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。
 
 无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。
 
 注意
 可失败构造器也可以代理到其它的非可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。
 */

//下面这个例子，定义了一个名为CartItem的Product类的子类。这个类建立了一个在线购物车中的物品的模型，它有一个名为quantity的常量存储型属性，并确保该属性的值至少为1：

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {return nil}
        self.name = name
    }
}


class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int){
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2){
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// 打印 "Unable to initialize zero shirts”



//重写一个可失败构造器

class Document {
    var name: String?
    
    init(){}
    init?(name: String){
        self.name = name
        if  name.isEmpty {
            return nil
        }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Unnamed]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Unnamed]"
        }
    }
    
}

//通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（(init!)），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Unnamed]")!
    }
}

//必要构造器
//在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
class SomeClass {
    required init(){
        print("init")
    }
}

class SomeSubClass: SomeClass {
    required init() {
        super.init()
        print("SubClass init")
    }
}


//通过闭包或函数设置属性的默认值

class ASomeClass {
    let someProperty: Int = {
        return 1
    }()
}


