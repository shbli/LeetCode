//
//  ThreeSum.swift
//  LeetCodeTest
//
//  Created by Shbli on 2020-07-01.
//  Copyright © 2020 Shbli. All rights reserved.
//

import XCTest

/// https://leetcode.com/problems/3sum/
class ThreeSum: XCTestCase {
    class Solution {
        func threeSum(_ nums: [Int]) -> [[Int]] {
            let sorted = nums.sorted()
            var result: [[Int]] = []
            for i in 0..<sorted.count {
                if i > 0 && sorted[i-1] == sorted[i] {
                    //we have already tested for this number let's move forward to a new one
                    continue
                }
                var left = i + 1
                var right = sorted.count - 1
                
                while left < right {
                    let sum = sorted[i] + sorted[left] + sorted[right]
                    if sum > 0 {
                        right -= 1
                    } else if sum < 0 {
                        left += 1
                    } else {
                        if result.last != [sorted[i], sorted[left], sorted[right]] {
                            result.append([sorted[i], sorted[left], sorted[right]])
                        }
                        right -= 1
                    }
                }
            }
            return result
        }
        
        func containsUnique(result: [[Int]], numbers: [Int]) -> Bool {
            return result.contains(where: {
                var array = Array($0)
                numbers.forEach { num in
                    if let index = array.firstIndex(where: { u in u == num}) {
                        array.remove(at: index)
                    }
                }
                return array.count == 0
            })
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
        
        var input = [Int]()
        var output = [[Int]]()
        
        input = [-1, 0, 1, 2, -1, -4]
        output = [[-1, -1, 2], [-1, 0, 1]]
        XCTAssert(s.threeSum(input) == output)
        
        input = [-4,-2,1,-5,-4,-4,4,-2,0,4,0,-2,3,1,-5,0]
        output = [[-5, 1, 4], [-4, 0, 4], [-4, 1, 3], [-2, -2, 4], [-2, 1, 1], [0, 0, 0]]
        XCTAssert(s.threeSum(input) == output)
        
        input = [0,3,0,1,1,-1,-5,-5,3,-3,-3,0]
        output = [[-3, 0, 3], [-1, 0, 1], [0, 0, 0]]
        XCTAssert(s.threeSum(input) == output)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        let s = Solution()
        var input = [Int]()
        self.measure {
            // Put the code you want to measure the time of here.
            input = [13,-5,3,3,-1,13,3,1,-9,-4,9,12,6,-9,-6,-12,-8,3,12,14,4,-15,2,-11,4,-12,10,9,-6,-3,-8,14,7,3,2,-8,-7,-10,8,-8,-7,-6,-11,6,-7,-2,9,-8,8,-2,13,-10,-2,0,-14,-13,-4,11,3,-3,-7,3,-4,8,13,13,-15,-9,10,0,-2,-12,1,2,9,1,8,-4,8,-7,9,7,-2,-15,14,0,-13,-13,-12,-2,-1,-11,8,10,12,6,8,4,12,3,11,-12,-2,-3,5,-15,6,-10,-4,-1,-1,-10,13]
            s.threeSum(input)
        }
    }
}

