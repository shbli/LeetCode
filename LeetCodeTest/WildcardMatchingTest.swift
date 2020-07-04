//
//  WildcardMatchingTest.swift
//  LeetCodeTest
//
//  Created by Shbli on 2020-06-27.
//  Copyright © 2020 Shbli. All rights reserved.
//

import XCTest

/// https://leetcode.com/problems/wildcard-matching/
class WildcardMatchingTest: XCTestCase {
    
    class Solution {
        func isMatch(_ s: String, _ p: String) -> Bool {
            ///Let's test if our pattern is larger than our text return false
            if p.replacingOccurrences(of: "*", with: "").count > s.count {
                return false
            }
            var dp = Array(repeating: Array(repeating: false, count: s.count+1), count: p.count+1)
            
            dp[0][0] = true
            
            for sI in 1..<s.count + 1 {
                dp[0][sI] = false
            }
            
            for pI in 1..<p.count + 1 {
                let pChar = p[pI - 1]
                
                dp[pI][0] = dp[pI - 1][0] && pChar == "*"
            }

            for sI in 1..<s.count + 1 {
                for pI in 1..<p.count + 1 {
                    let sChar = s[sI - 1]
                    let pChar = p[pI - 1]
                    
                    if (sChar == pChar || pChar == "?") {
                        dp[pI][sI] = dp[pI - 1][sI - 1]
                    } else if (pChar == "*" ) {
                        dp[pI][sI] = dp[pI][sI - 1] || dp[pI - 1][sI]
                    } else {
                        dp[pI][sI] = false
                    }
                }
            }
            
            return dp[p.count][s.count]
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let s = Solution()
        
        
        XCTAssert(s.isMatch(
            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        "*aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa*") == false)
        
        XCTAssert(s.isMatch("stadium", "s*u?") == true)
        XCTAssert(s.isMatch("baaaa", "*aaa") == true)
        XCTAssert(s.isMatch("abb", "**??") == true)
        XCTAssert(s.isMatch("", "?") == false)
        XCTAssert(s.isMatch("abc", "*abc?*") == false)
        XCTAssert(s.isMatch("hi", "*?") == true)
        XCTAssert(s.isMatch("abefcdgiescdfimde", "ab*cd?i*de") == true)
        XCTAssert(s.isMatch("a", "aa") == false)
        XCTAssert(s.isMatch("aa", "a") == false)
        XCTAssert(s.isMatch("aa", "*") == true)
        XCTAssert(s.isMatch("aa", "****") == true)
        XCTAssert(s.isMatch("cb", "?a") == false)
        XCTAssert(s.isMatch("adceb", "*a*b") == true)
        XCTAssert(s.isMatch("acdcb", "a*c?b") == false)
        XCTAssert(s.isMatch("aa", "aa") == true)
        XCTAssert(s.isMatch("aa", "aa*") == true)
        XCTAssert(s.isMatch("adceb", "*a*bws") == false)
        XCTAssert(s.isMatch("", "*") == true)
        XCTAssert(s.isMatch("", "") == true)
        XCTAssert(s.isMatch("aaaa", "***a") == true)
        XCTAssert(s.isMatch("mississippi", "m??*ss*?i*pi") == false)
        XCTAssert(s.isMatch("sissippi", "*ss*?i*pi") == false)
    }
}

