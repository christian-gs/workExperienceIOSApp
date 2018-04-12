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

func palindrome(value: String) -> String {
    if String(value.lowercased().reversed()) == value.lowercased() {
        return (value + " is a palindrome")
    } else {
        return (value + " is not a palindrome")
    }
}

func primeNumberChecker(value: Int) -> String {
    var isPrime: Bool = true
    
    //This does not need to account for 2 because 2 is a prime (see the default value of true for "isPrime")
    if value == 1 {
        isPrime = false
    } else if value > 2 && value % 2 != 0 {
        for x in stride(from: 3, through: value / 2, by: 2) {
            if value % x == 0 {
                isPrime = false
                break
            }
        }
    } else {
        isPrime = false
    }
    
    if isPrime {
        return(String(value) + " is a prime number")
    } else {
        return(String(value) + " is not a prime number")
    }

}

func linearSearch(arrayToSearch: [Int], value: Int) -> String {
    //count use a ternary here but best not I suppose
    if arrayToSearch.contains(value) {
        return("The array contains " + String(value))
    } else {
        return("The array does not contain " + String(value))
    }
}
