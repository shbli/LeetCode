//
//  MaxPointsOnALine.swift
//  LeetCodeTest
//
//  Created by Shbli on 2020-06-30.
//  Copyright © 2020 Shbli. All rights reserved.
//

import XCTest

/// https://leetcode.com/problems/wildcard-matching/
class MaxPointsOnALine: XCTestCase {
    
    class Solution {
        func maxPoints(_ points: [[Int]]) -> Int {
            if points.count <= 2 { return points.count }
            
            var pointsOnSlopeHash: [Float80: Int] = [:]
            var result = 0
            
            for i in 0..<points.count-1 {
                let x1 = points[i][0]
                let y1 = points[i][1]
                
                pointsOnSlopeHash.removeAll()
                var overlap = 0
                
                for j in i+1..<points.count {
                    let x2 = points[j][0]
                    let y2 = points[j][1]
                    
                    if x2 == x1 && y2 == y1 {
                        overlap += 1
                        result = [overlap, result].max()!
                        pointsOnSlopeHash.forEach({
                            pointsOnSlopeHash[$0.key]! += 1
                            result = [pointsOnSlopeHash[$0.key] ?? 0, overlap, result].max()!
                        })
                        continue
                    }
                    
                    ///we can't divide by 0 if x1 == x2 so our slop will be equal to our x
                    let slope: Float80 = (x1 == x2) ? Float80.infinity : Float80(y1 - y2) / Float80(x1 - x2)
                    if let pointsOnSlope = pointsOnSlopeHash[slope] {
                        pointsOnSlopeHash[slope] = pointsOnSlope + 1
                    } else {
                        pointsOnSlopeHash[slope] = 1 + overlap
                    }
                    result = [pointsOnSlopeHash[slope] ?? 0, overlap, result].max()!
                }
            }
            
            return result + 1
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
        
        
        XCTAssert(s.maxPoints([[0,0],[1,65536],[65536,0]]) == 2)
        XCTAssert(s.maxPoints([[1,1],[1,1],[2,3]]) == 3)
        XCTAssert(s.maxPoints([[2,3],[3,3],[-5,3]]) == 3)
        XCTAssert(s.maxPoints([[0,0],[1,1],[0,0]]) == 3)
        XCTAssert(s.maxPoints([[0,0],[1,3],[3,2]]) == 2)
        XCTAssert(s.maxPoints([[0,0],[1,1],[2,2]]) == 3)
        XCTAssert(s.maxPoints([[1,1],[1,2],[1,3]]) == 3)
        XCTAssert(s.maxPoints([[1,1],[2,2],[3,3]]) == 3)
        XCTAssert(s.maxPoints([[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]) == 4)
    }
}

