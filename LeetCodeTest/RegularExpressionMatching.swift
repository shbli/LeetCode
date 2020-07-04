//
//  RegularExpressionMatching.swift
//  LeetCodeTest
//
//  Created by Shbli on 2020-07-04.
//  Copyright © 2020 Shbli. All rights reserved.
//

import XCTest

extension StringProtocol {
    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
}

/// https://leetcode.com/problems/regular-expression-matching/
class RegularExpressionMatching: XCTestCase {
    class Solution {
        func isMatch(_ s: String, _ p: String) -> Bool {
            var modifiedPattern = [String]()
            p.forEach({ char in
                if char == "*" {
                    if let last = modifiedPattern.popLast() {
                        modifiedPattern.append( last + String( char ) )
                    } else {
                        print("Solution not possible")
                    }
                } else {
                    modifiedPattern.append( String( char ) )
                }
            })
            var dp = Array(repeating: Array(repeating: false, count: s.count+1), count: modifiedPattern.count+1)
            
            dp[0][0] = true
            
            for sI in 1..<s.count + 1 {
                dp[0][sI] = false
            }
            
            for pI in 1..<modifiedPattern.count + 1 {
                let pChar = modifiedPattern[pI - 1]
                
                dp[pI][0] = dp[pI - 1][0] && pChar.count > 1 && pChar[1] == "*"
            }
            

            for sI in 1..<s.count + 1 {
                for pI in 1..<modifiedPattern.count + 1 {
                    let sChar = s[sI - 1]
                    let pChar = modifiedPattern[pI - 1]
                    
                    guard pChar.count > 0 else {
                        print("Solution not possible")
                        return false
                    }
                    if pChar.count > 1 && pChar[1] == "*" {
                        if (sChar == pChar[0] || pChar[0] == ".") {
                            dp[pI][sI] = dp[pI][sI - 1] || dp[pI - 1][sI] || dp[pI - 1][sI - 1]
                        } else {
                            dp[pI][sI] = dp[pI - 1][sI]
                        }
                    } else if (sChar == pChar[0] || pChar[0] == ".") {
                        dp[pI][sI] = dp[pI - 1][sI - 1]
                    } else {
                        dp[pI][sI] = false
                    }
                }
            }
            
            return dp[modifiedPattern.count][s.count]
        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let s = Solution()
        
        var input = ["aa", "a"]
        var output = false
        
        input = ["mi", "mis*"]
        output = true
        XCTAssert(s.isMatch(input[0], input[1]) == output)

        input = ["", "a"]
        output = false
        XCTAssert(s.isMatch(input[0], input[1]) == output)

        input = ["aa", "a"]
        output = false
        XCTAssert(s.isMatch(input[0], input[1]) == output)

        input = ["aa", "a*"]
        output = true
        XCTAssert(s.isMatch(input[0], input[1]) == output)

        input = ["ab", ".*"]
        output = true
        XCTAssert(s.isMatch(input[0], input[1]) == output)

        input = ["aab", "c*a*b"]
        output = true
        XCTAssert(s.isMatch(input[0], input[1]) == output)

        input = ["mississippi", "mis*is*p*."]
        output = false
        XCTAssert(s.isMatch(input[0], input[1]) == output)


        input = ["mississippi", ""]
        output = false
        XCTAssert(s.isMatch(input[0], input[1]) == output)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        let s = Solution()
        var input = [Int]()
        self.measure {
            // Put the code you want to measure the time of here.
            var input = ["aa", "a"]
            var output = false
            XCTAssert(s.isMatch(input[0], input[1]) == output)
        }
    }
}

