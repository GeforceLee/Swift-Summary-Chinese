//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
 计数引用只适用于类的实例。结构体和枚举类型都是值类型，不是引用类型
 */
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
    
}


//在这点所有的引用都是nil
var reference1: Person?
var reference2: Person?
var reference3: Person?


reference1 = Person(name: "John")

//现在有3个强引用
reference2 = reference1
reference3 = reference1

//2个
reference1 = nil
//1个
reference2 = nil

//没有引用了  Person被释放了
reference3 = nil




/*
 强循环引用
 */


class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit}
    
    var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinit")
    }
}



class Tenant: Person {
    var apartment: Apartment?
}


var john: Tenant?
var unit4A: Apartment?

john = Tenant(name: "John Li")
unit4A = Apartment(unit: "4A")

//在这产生了循环引用
john?.apartment = unit4A
unit4A?.tenant = john

//当我们把变量设为nil的时候也不会释放资源。这种循环引用就产生了内存泄漏了
john = nil
unit4A = nil

/*
 解决循环引用
 Swift提供了2种方法：弱引用（weak reference）和无主引用（unowned reference）
 对于生命周期中会变为nil的实例使用弱引用。相反的，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用
 
 */

/*
 弱引用
 
 弱引用不会牢牢保持住引用的实例，并且不会阻止 ARC 销毁被引用的实例。这种行为阻止了引用变为循环强引用。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
 
 在实例的生命周期中，如果某些时候引用没有值，那么弱引用可以阻止循环强引用。如果引用总是有值，则可以使用无主引用，在无主引用中有描述。在上面Apartment的例子中，一个公寓的生命周期中，有时是没有“居民”的，因此适合使用弱引用来解决循环强引用。
 
 注意:
 弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。
 因为弱引用可以没有值，你必须将每一个弱引用声明为可选类型。可选类型是在 Swift 语言中推荐的用来表示可能没有值的类型。
 因为弱引用不会保持所引用的实例，即使引用存在，实例也有可能被销毁。因此，ARC 会在引用的实例被销毁后自动将其赋值为nil。你可以像其他可选值一样，检查弱引用的值是否存在，你永远也不会遇到被销毁了而不存在的实例。
 */


class NewPerson {
    let name: String
    init(name: String) { self.name = name}
    var apartment: NewApartment?
    deinit {
        print("New person \(name) is being deinit")
    }
}

class NewApartment {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    
    weak var tenant: NewPerson?
    deinit {
        print("Apartment #\(number) is being deinit")
    }
}



var newJohn: NewPerson?
var number73: NewApartment?

newJohn = NewPerson(name: "New John")
number73 = NewApartment(number: 73)

newJohn?.apartment = number73
number73?.tenant = newJohn


newJohn = nil

number73 = nil
/*
 无主引用
 
 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
 
 由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
 
 注意:
 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。使用无主引用，你必须确保引用始终指向一个未销毁的实例。
 还需要注意的是如果你试图访问实例已经被销毁的无主引用，程序会直接崩溃，而不会发生无法预期的行为。所以你应当避免这样的事情发生。
 */


class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinit")
    }
}


class CreditCard {
    let number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer){
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinit")
    }
}

var jack: Customer?

jack = Customer(name: "Jack")

jack?.card = CreditCard(number: 1111_2222, customer: jack!)

jack = nil


/*
 上面弱引用和无主引用的例子涵盖了两种常用的需要打破循环强引用的场景。
 
 Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
 
 Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，并会潜在的产生循环强引用。这种场景最适合通过无主引用来解决。
 
 然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后不能为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
 
 这使两个属性在初始化完成后能被直接访问（不需要可选展开），同时避免了循环引用。这一节将为你展示如何建立这种关系。
 */
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

/*
 闭包引起的循环强引用
 
 前面我们看到了循环强引用环是在两个类实例属性互相保持对方的强引用时产生的，还知道了如何用弱引用和无主引用来打破循环强引用。
 
 循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了实例。这个闭包体中可能访问了实例的某个属性，例如self.someProperty，或者闭包中调用了实例的某个方法，例如self.someMethod。这两种情况都导致了闭包 “捕获" self，从而产生了循环强引用。
 
 循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把一个闭包赋值给某个属性时，你也把一个引用赋值给了这个闭包。实质上，这跟之前的问题是一样的－两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包。
 
 Swift 提供了一种优雅的方法来解决这个问题，称之为闭包占用列表（closuer capture list）。同样的，在学习如何用闭包占用列表破坏循环强引用之前，先来了解一下循环强引用是如何产生的，这对我们是很有帮助的。
 
 下面的例子为你展示了当一个闭包引用了self后是如何产生一个循环强引用的。例子中定义了一个叫HTMLElement的类，用一种简单的模型表示 HTML 中的一个单独的元素：
 */

class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML:() -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being inited")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello,world")
print(paragraph!.asHTML())
paragraph = nil


/*
 解决闭包引起的循环强引用
 
 在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
 
 注意:
 Swift 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod（而不只是someProperty或someMethod）。这提醒你可能会不小心就捕获了self。
 定义捕获列表
 
 捕获列表中的每个元素都是由weak或者unowned关键字和实例的引用（如self或someInstance）成对组成。每一对都在方括号中，通过逗号分开。
 
 捕获列表放置在闭包参数列表和返回类型之前：
 
 lazy var someClosure: (Int, String) -> String = {
 [unowned self] (index: Int, stringToProcess: String) -> String in
 // closure body goes here
 }
 如果闭包没有指定参数列表或者返回类型，则可以通过上下文推断，那么可以捕获列表放在闭包开始的地方，跟着是关键字in：
 
 lazy var someClosure: () -> String = {
 [unowned self] in
 // closure body goes here
 }
 */


class NewHTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned  self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name) />"
        }
    }
    
    //lazy var asHTML: () -> String = {
        //[weak  self] in
        //if let text = self?.text {
            //return "<\(self?.name)>\(text)</\(self?.name)>"
        //}else {
            //return "<\(self?.name) />"
        //}
    //}

    
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinited")
    }
    
}

var newParagraph: NewHTMLElement? = NewHTMLElement(name: "new p", text: "hello")
print(newParagraph!.asHTML())
newParagraph = nil
