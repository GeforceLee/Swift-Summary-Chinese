//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Matrix {
    let rows:Int,columns:Int
    var grid: [Double]
    init(rows:Int,columns:Int){
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row:Int,column:Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column <= columns
    }
    
    //这就是定义下标的方法
    //可以通过 matrix[x,y] 来使用
    subscript(row:Int,column:Int) -> Double {
        //下标可以是 读写，只读，只写
        get {
            assert(indexIsValidForRow(row, column: column),"Index out of range")
            return grid[row * columns + column]
        }
        
        set {
            assert(indexIsValidForRow(row, column: column),"Index out of range")
            grid[row * columns + column] = newValue
        }
    }
    
}



var matrix = Matrix(rows: 2, columns: 2)

matrix[0,0] = 2.5

let number = matrix[0,0]

print(number)

//超出范围会报错
matrix[3,3] = 4.5

