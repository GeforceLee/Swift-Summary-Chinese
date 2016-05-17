//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 可选链（Optional Chaining）是一种可以请求和调用属性、方法及下标脚本的过程，它的可选性体现于请求或调用的目标当前可能为空（nil）。如果可选的目标有值，那么调用就会成功；相反，如果选择的目标为空（nil），则这种调用将返回空（nil）。多次请求或调用可以被链接在一起形成一个链，如果任何一个节点为空（nil）将导致整个链失效。
 
 注意：
 Swift 的可选链和 Objective-C 中的消息为空有些相像，但是 Swift 可以使用在任意类型中，并且失败与否可以被检测到。
 
  */

/*
 可选链（Optional Chaining）是一种可以请求和调用属性、方法及下标脚本的过程，它的可选性体现于请求或调用的目标当前可能为空（nil）。如果可选的目标有值，那么调用就会成功；相反，如果选择的目标为空（nil），则这种调用将返回空（nil）。多次请求或调用可以被链接在一起形成一个链，如果任何一个节点为空（nil）将导致整个链失效。
 
 注意：
 Swift 的可选链和 Objective-C 中的消息为空有些相像，但是 Swift 可以使用在任意类型中，并且失败与否可以被检测到。
 
 可选链可替代强制解析
 
 通过在想调用的属性、方法、或下标脚本的可选值（optional value）（非空）后面放一个问号，可以定义一个可选链。这一点很像在可选值后面放一个叹号来强制拆得其封包内的值。它们的主要的区别在于当可选值为空时可选链即刻失败，然而一般的强制解析将会引发运行时错误。
 
 为了反映可选链可以调用空（nil），不论你调用的属性、方法、下标脚本等返回的值是不是可选值，它的返回结果都是一个可选值。你可以利用这个返回值来检测你的可选链是否调用成功，有返回值即成功，返回nil则失败。
 
 调用可选链的返回结果与原本的返回结果具有相同的类型，但是原本的返回结果被包装成了一个可选值，当可选链调用成功时，一个应该返回Int的属性将会返回Int?。
 
 下面几段代码将解释可选链和强制解析的不同。
 
 首先定义两个类Person和Residence。
 */
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}
/*
 Residence具有一个Int类型的numberOfRooms，其值为 1。Person具有一个可选residence属性，它的类型是Residence？。
 
 如果你创建一个新的Person实例，它的residence属性由于是被定义为可选型的，此属性将默认初始化为空：
 */
let john = Person()



//如果你想使用感叹号（!）强制解析获得这个人residence属性numberOfRooms属性值，将会引发运行时错误，因为这时没有可以供解析的residence值。
//let roomCount = john.residence!.numberOfRooms



/*
 当john.residence不是nil时，会运行通过，且会将roomCount 设置为一个int类型的合理值。然而，如上所述，当residence为空时，这个代码将会导致运行时错误。
 
 可选链提供了一种另一种获得numberOfRooms的方法。利用可选链，使用问号来代替原来!的位置：
 */

if let roomCount = john.residence?.numberOfRooms {
    print("John;s residence has \(roomCount) room(s)")
}else {
    print("Unable to retrieve the number of rooms.")
}

/*
 这告诉 Swift 来链接可选residence?属性，如果residence存在则取回numberOfRooms的值。
 
 因为这种尝试获得numberOfRooms的操作有可能失败，可选链会返回Int?类型值，或者称作“可选Int”。当residence是空的时候（上例），选择Int将会为空，因此会出现无法访问numberOfRooms的情况。
 
 要注意的是，即使numberOfRooms是非可选Int（Int?）时这一点也成立。只要是通过可选链的请求就意味着最后numberOfRooms总是返回一个Int?而不是Int。
 
 你可以自己定义一个Residence实例给john.residence，这样它就不再为空了：
 */

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John;s residence has \(roomCount) room(s)")
}else {
    print("Unable to retrieve the number of rooms.")
}


/*
 为可选链定义模型类
 
 你可以使用可选链来多层调用属性，方法，和下标脚本。这让你可以利用它们之间的复杂模型来获取更底层的属性，并检查是否可以成功获取此类底层属性。
 
 后面的代码定义了四个将在后面使用的模型类，其中包括多层可选链。这些类是由上面的Person和Residence模型通过添加一个Room和一个Address类拓展来。
 
 Person类定义与之前相同。

 */
class NewPerson{
    var residence: NewResidence?
}

//Residence类比之前复杂些。这次，它定义了一个变量 rooms，它被初始化为一个Room[]类型的空数组：
class NewResidence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        return rooms[i]
    }
    
    func printNumberOfRooms() -> Void {
        return print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}


class Room {
    let name: String
    init(name: String){self.name = name}
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if  (buildingName != nil) {
            return buildingName
        }else if (buildingNumber != nil) {
            return buildingNumber
        }else {
            return nil
        }
    }
}



let jack = NewPerson()
if let roomCount = jack.residence?.numberOfRooms {
    print("Jack's residence has \(roomCount)  rooms(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

let jackHouse = NewResidence()
jackHouse.rooms += [Room(name: "Living Room")]
jackHouse.rooms += [Room(name: "Kitchen")]
jack.residence = jackHouse

if let firstRoomName = jack.residence?[0].name {
    print("The first room name is \(firstRoomName).")
}else{
    print("Unable to retrieve the first room name.")
}


let jackAddress = Address()
jackAddress.buildingName = "The Larches"
jackAddress.street = "Laurel Street"
jack.residence!.address = jackAddress

if let jackStreet = jack.residence?.address?.street {
    print("Jack's street name is \(jackStreet).")
}else{
    print("Unable to retrieve the address.")
}


if let buildingIdentifier = jack.residence?.address?.buildingIdentifier() {
    print("Jack's building identifier is \(buildingIdentifier).")
}


if let upper = jack.residence?.address?.buildingIdentifier()?.uppercaseString {
    print("Jack's uppercase building identifier is \(upper).")
}
