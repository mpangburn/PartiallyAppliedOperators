//
//  PartialOperatorApplication.swift
//  PartialOperatorApplication
//
//  Created by Michael Pangburn on 2/5/18.
//  Copyright © 2018 Michael Pangburn. All rights reserved.
//

// MARK: - Equatable operators

prefix operator ==
prefix func == <T: Equatable> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 == rhs }
}

postfix operator ==
postfix func == <T: Equatable> (lhs: T) -> (_ rhs: T) -> Bool {
    return { lhs == $0 }
}

prefix operator !=
prefix func != <T: Equatable> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 != rhs }
}

/* Postfix operators cannot begin with '!' because of its use with Optionals */
// postfix operator !=
// postfix func != <T: Equatable> (lhs: T) -> (_ rhs: T) -> Bool {
//     return { lhs != $0 }
// }

prefix operator ~=
prefix func ~= <T: Equatable> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 ~= rhs }
}

postfix operator ~=
postfix func ~= <T: Equatable> (lhs: T) -> (_ rhs: T) -> Bool {
    return { lhs ~= $0 }
}

// MARK: - Identity equatable operators

prefix operator ===
prefix func === <T: AnyObject> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 === rhs }
}

postfix operator ===
postfix func === <T: AnyObject> (lhs: T) -> (_ rhs: T) -> Bool {
    return { lhs === $0 }
}

prefix operator !==
prefix func !== <T: AnyObject> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 !== rhs }
}

/* Postfix operators cannot begin with '!' because of its use with Optionals */
// postfix operator !==
// postfix func !== <T: AnyObject> (lhs: T) -> (_ rhs: T) -> Bool {
//     return { lhs !== $0 }
// }

// MARK: - Comparable operators

/* Prefix '<' is presumably reserved to avoid confusion in identifying generics */
// prefix operator <
// prefix func < <T: Comparable> (rhs: T) -> (_ lhs: T) -> Bool {
//     return { $0 < rhs }
// }

postfix operator <
postfix func < <T: Comparable> (lhs: T) -> (_ rhs: T) -> Bool {
    return { lhs < $0 }
}

prefix operator >
prefix func > <T: Comparable> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 > rhs }
}

/* Postfix '>' is presumably reserved to avoid confusion in identifying generics */
// postfix operator >
// postfix func > <T: Comparable> (lhs: T) -> (_ rhs: T) -> Bool {
//     return { lhs > $0 }
// }

prefix operator <=
prefix func <= <T: Comparable> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 <= rhs }
}

postfix operator <=
postfix func <= <T: Comparable> (lhs: T) -> (_ rhs: T) -> Bool {
    return { lhs <= $0 }
}

prefix operator >=
prefix func >= <T: Comparable> (rhs: T) -> (_ lhs: T) -> Bool {
    return { $0 >= rhs }
}

postfix operator >=
postfix func >= <T: Comparable> (lhs: T) -> (_ rhs: T) -> Bool {
    return { lhs >= $0 }
}

// MARK: - Numeric operators

prefix func + <T: Numeric> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 + rhs }
}

postfix operator +
postfix func + <T: Numeric> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs + $0 }
}

/* Interestingly, overloading unary '+' works fine, but not unary '-' */
// prefix func - <T: Numeric> (rhs: T) -> (_ lhs: T) -> T {
//     return { $0 - rhs }
// }

postfix operator -
postfix func - <T: Numeric> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs - $0 }
}

prefix operator *
prefix func * <T: Numeric> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 * rhs }
}

postfix operator *
postfix func * <T: Numeric> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs * $0 }
}

// MARK: - FloatingPoint operators

prefix operator /
prefix func / <T: FloatingPoint> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 / rhs }
}

postfix operator /
postfix func / <T: FloatingPoint> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs / $0 }
}

// MARK: - BinaryInteger operators

prefix func / <T: BinaryInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 / rhs }
}

postfix func / <T: BinaryInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs / $0 }
}

prefix operator %
prefix func % <T: BinaryInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 % rhs }
}

postfix operator %
postfix func % <T: BinaryInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs % $0 }
}

/* Prefix '&' is reserved for passing variables as inout parameters */
// prefix operator &
// prefix func & <T: BinaryInteger> (rhs: T) -> (_ lhs: T) -> T {
//     return { $0 & rhs }
// }

postfix operator &
postfix func & <T: BinaryInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs & $0 }
}

prefix operator |
prefix func | <T: BinaryInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 | rhs }
}

postfix operator |
postfix func | <T: BinaryInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs | $0 }
}

prefix operator ^
prefix func ^ <T: BinaryInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 ^ rhs }
}

postfix operator ^
postfix func ^ <T: BinaryInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs ^ $0 }
}

prefix operator <<
prefix func << <T: BinaryInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 << rhs }
}

postfix operator <<
postfix func << <T: BinaryInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs << $0 }
}

prefix operator >>
prefix func >> <T: BinaryInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 >> rhs }
}

postfix operator >>
postfix func >> <T: BinaryInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs >> $0 }
}

// MARK: - FixedWidthInteger operators

prefix operator &+
prefix func &+ <T: FixedWidthInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 &+ rhs }
}

postfix operator &+
postfix func &+ <T: FixedWidthInteger> (lhs: T) -> (_ lhs: T) -> T {
    return { lhs &+ $0 }
}

prefix operator &-
prefix func &- <T: FixedWidthInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 &- rhs }
}

postfix operator &-
postfix func &- <T: FixedWidthInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs &- $0 }
}

prefix operator &*
prefix func &* <T: FixedWidthInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 &* rhs }
}

postfix operator &*
postfix func &* <T: FixedWidthInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs &* $0 }
}

prefix operator &<<
prefix func &<< <T: FixedWidthInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 &<< rhs }
}

postfix operator &<<
postfix func &<< <T: FixedWidthInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs &<< $0 }
}

prefix operator &>>
prefix func &>> <T: FixedWidthInteger> (rhs: T) -> (_ lhs: T) -> T {
    return { $0 &>> rhs }
}

postfix operator &>>
postfix func &>> <T: FixedWidthInteger> (lhs: T) -> (_ rhs: T) -> T {
    return { lhs &>> $0 }
}

// MARK: - Bool operators

prefix operator &&
prefix func && (rhs: @escaping @autoclosure () -> Bool) -> (_ lhs: Bool) -> Bool {
    return { $0 && rhs() }
}

postfix operator &&
postfix func && (lhs: Bool) -> (_ rhs: Bool) -> Bool {
    return { lhs && $0 }
}

prefix operator ||
prefix func || (rhs: @escaping @autoclosure () -> Bool) -> (_ lhs: Bool) -> Bool {
    return { $0 || rhs() }
}

postfix operator ||
postfix func || (lhs: Bool) -> (_ rhs: Bool) -> Bool {
    return { lhs || $0 }
}

// MARK: - Optional operators

prefix operator ??
prefix func ?? <T> (rhs: @escaping @autoclosure () -> T) -> (_ lhs: T?) -> T {
    return { $0 ?? rhs() }
}

/* Postfix operators cannot begin with '?' because of its use with Optionals */
// postfix operator ??
// postfix func ?? <T> (lhs: T?) -> (_ rhs: T) -> T {
//     return { lhs ?? $0 }
// }

// MARK: - Utilities

func not<T>(_ f: @escaping (T) -> Bool) -> (T) -> Bool {
    return { !f($0) }
}

prefix func ! <T> (f: @escaping (T) -> Bool) -> (T) -> Bool {
    return { !f($0) }
}

// c.f. https://oleb.net/blog/2015/09/swift-pattern-matching/
func ~= <T> (pattern: (T) -> Bool, value: T) -> Bool {
    return pattern(value)
}

