//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var test1 = testClass()
test1.myType = .typeA

var test2 = testClass()
test1.myType = .typeA

var test3 = testClass()
test1.myType = .typeB

var array = [test1,test2,test3]

let b = array[1] is testClass

let a = array.filter($0 is testClass)
a.count


class testClass : NSObject {
    var myType : typeTest!
}

enum typeTest {
    case typeA
    case typeB
}