//
//  File.swift
//  programmingPractice
//
//  Created by Christian on 4/10/18.
//  Copyright © 2018 Gridstone. All rights reserved.
//

import Foundation

func addition(value1: Int, value2: Int) -> String {

    let result = value1 + value2
    return "\(result)"
}

func multiply(value1: Int, value2: Int) -> String {

    let result = value1 * value2
    return "\(result)"
}

func countToV1(value: Int) ->String {
    var result = ""

    for i in 1...value {
        result += "\(i), "
    }

    return result
}

func countToV2(value: Int) ->String {
    var result = ""

    var i = 1
    while(i <= value) {
        result += "\(i), "
        i += 1
    }

    return result
}

func factorialOf(value: Double) -> String {

    var result = value
    var number = value

    repeat {
        result = result * (number - 1)
        number -= 1
    }while( number > 1)

    return "\(result)"
}

func returnEvenNumbers(array: [Int]) -> String {

    var result = ""
    for num in array {

        if num % 2 == 0 {
            result += "\(num), "
        }
    }
    return result
}

func returnLargestNumber(array: [Int]) -> String {
    var result = 0
    for num in array {

        if num > result {
            result = num
        }
    }

    return "\(result)"
}
