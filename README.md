# Partially Applied Operators

[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](#)
[![@pangburnout](https://img.shields.io/badge/contact-@pangburnout-blue.svg?style=flat)](https://twitter.com/pangburnout)

A thought experiment in bringing the semantics of Haskell's partial application of operators to Swift.

## Background
In functional programming languages, [currying](https://en.wikipedia.org/wiki/Currying) enables the partial application of functions. For example, consider a function `add` that takes two integer arguments and returns their sum. Currying allows a single argument to be passed to `add` to create a new function. This new function takes only a single integer argument and returns its sum with the first argument passed. When `add` is passed only a single argument, it is partially applied. 

In a language like Haskell, functions that take multiple arguments are inherently curried. For example, here is the signature of `add` in Haskell:

```haskell
add :: Int -> Int -> Int
```

Notice how the return `->` separates not just the arguments from the return type, but also the arguments from one another. In Swift, we might think to write the signature of `add` like so:

```swift
func add(_ x: Int, _ y: Int) -> Int
```

However, when defined in this manner, `add` is not curried. To make use of `add` as a curried function in Swift, we would write its signature in a different way:

```swift
func add(_ x: Int) -> (_ y: Int) -> Int
```

This curried `add` would be used slightly differently from how we defined it initially:

```swift
// Using definition 1:
add(2, 4) // 6

// Using definition 2:
add(2)(4) // 6
```

While the extra pair of parentheses is unappealing, we gain powerful functionality through currying:

```swift
let add2 = add(2)
add2(4)  // 6
add2(10) // 12
```

In this way, currying allows for composable, reusable functions.

Since operators are really just infix functions with special symbols, they can also be partially applied. Partially appplied operators are especially useful for mapping over or filtering a list:

```haskell
numbers = [1, 2, 3, 4, 5]
map (+2) numbers     -- [3, 4, 5, 6, 7]
filter (>=3) numbers -- [3, 4, 5]
```

In Swift, we can do something similar using trailing closure syntax:

```swift
let numbers = [1, 2, 3, 4, 5]
numbers.map { $0 + 2 }     // [3, 4, 5, 6, 7]
numbers.filter { $0 >= 3 } // [3, 4, 5]
```

However, there is a key difference here: in the Haskell example, we make use of operators without explicitly identifying their operands—this is called [point-free style](https://en.wikipedia.org/wiki/Tacit_programming). In Swift, we identify the operand in the map or filter with `$0`.

The goal of this project is to bring the semantics of Haskell's partially applied operators to Swift:

```swift
let numbers = [1, 2, 3, 4, 5]
numbers.map(+2)     // [3, 4, 5, 6, 7]
numbers.filter(>=3) // [3, 4, 5]
```

## Implementation
The built-in operators defined in the Swift Standard Library are not curried. We could curry them using a [helper function](https://github.com/pointfreeco/swift-prelude/blob/b23463ebd7c1ce11600f86cbcb8165098fd44693/Sources/Prelude/Curry.swift), but calling `curry` whenever we partially apply an operator would be inelegant and obscure our intent.

Instead, we define "unary" versions of the infix operators in order to partially apply them. For example, our `add` example from above becomes

```swift
prefix func + <T: Numeric> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 + rhs }
}
```

Where possible, we define both prefix and postfix versions of operators:

```swift
postfix func + <T: Numeric> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs + $0 }
}
```

Defining both versions is most important for operations that are not commutative, such as division.

## Limitations
Some limitations are imposed on operator declarations in certain contexts:

- The less-than symbol `<` cannot be used as a prefix operator, and the greater-than symbol `>` cannot be used as a postfix operator. These symbols are reserved in these contexts to avoid compiler confusion in identifying generics.
- An overloaded prefix `-` on Numeric types is not properly interpreted by the compiler. Interestingly, `+` does not have this problem despite also being already defined as a prefix operator on Numeric types.
- Prefix `&` is reserved for passing variables as inout parameters, so it cannot be used as a prefix in partially applying the bitwise AND operator.__*__
- Postfix operators cannot begin with '!' because of its use with Optionals, which prevents the postfix definitions of `!=` and `!==`.__*__
- Postfix operators cannot begin with '?' because of its use with Optionals, which prevents the postfix definition of `??`.

__*__ In practice, the restrictions on these operators are trivial since their operations are commutative, and either their prefix or postfix version can be implemented without issues.

## Looking Forward
While [SE-002](https://github.com/apple/swift-evolution/blob/master/proposals/0002-remove-currying.md) removed previous syntax for currying, it also included some brief thoughts on [the future of currying in Swift](https://github.com/apple/swift-evolution/blob/master/proposals/0002-remove-currying.md#alternatives-considered). While we have yet to see movement on this front, inherently curried functions would have significant implications for the functional Swift community. Hopefully, the syntax introduced through this project will one day be native to Swift through built-in partial function application.