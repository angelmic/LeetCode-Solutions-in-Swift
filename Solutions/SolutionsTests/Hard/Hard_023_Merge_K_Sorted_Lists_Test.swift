//
//  Hard_023_Merge_K_Sorted_Lists_Test.swift
//  Solutions
//
//  Created by Di Wu on 5/5/15.
//  Copyright (c) 2015 diwu. All rights reserved.
//

import XCTest

class Hard_023_Merge_K_Sorted_Lists_Test: XCTestCase {
    private static let ProblemName: String = "Hard_023_Merge_K_Sorted_Lists"
    private static let TimeOutName = ProblemName + Default_Timeout_Suffix
    private static let TimeOut = Default_Timeout_Value

    private typealias Node = Hard_023_Merge_K_Sorted_Lists.Node

    func test_001() {
        var input: [Node?] = [helper1([1]), helper1([2])]
        var expected: [Int] = [1, 2]
        asyncHelper(input: input, expected: expected)
    }
    func test_002() {
        var input: [Node?] = [helper1([]), helper1([2])]
        var expected: [Int] = [2]
        asyncHelper(input: input, expected: expected)
    }
    func test_003() {
        var input: [Node?] = [helper1([1]), helper1([])]
        var expected: [Int] = [1]
        asyncHelper(input: input, expected: expected)
    }
    func test_004() {
        var input: [Node?] = [helper1([]), helper1([]), helper1([])]
        var expected: [Int] = []
        asyncHelper(input: input, expected: expected)
    }
    func test_005() {
        var input: [Node?] = [helper1([1]), helper1([3]), helper1([2])]
        var expected: [Int] = [1, 2, 3]
        asyncHelper(input: input, expected: expected)
    }
    func test_006() {
        var input: [Node?] = [helper1([1, 2, 3, 6]), helper1([3, 4, 5]), helper1([3])]
        var expected: [Int] = [1, 2, 3, 3, 3, 4, 5, 6]
        asyncHelper(input: input, expected: expected)
    }
    func test_007() {
        var input: [Node?] = [helper1([])]
        var expected: [Int] = []
        asyncHelper(input: input, expected: expected)
    }
    private func helper1(intArray: [Int]) -> Node? {
        var nodeArray: [Node] = []
        for i in intArray {
            var node: Node = Node(value: i, next: nil)
            nodeArray.append(node)
        }
        if nodeArray.count == 0 {
            return nil
        }
        for i in 0..<nodeArray.count-1 {
            nodeArray[i].next = nodeArray[i+1]
        }
        return nodeArray[0]
    }
    private func helper2(head: Node?) -> [Int] {
        var res: [Int] = []
        var localHead = head
        while localHead != nil {
            res.append(localHead!.value)
            localHead = localHead?.next
        }
        return res
    }
    private func asyncHelper(# input: [Node?], expected: [Int]) {
        var expectation: XCTestExpectation = self.expectationWithDescription(Hard_023_Merge_K_Sorted_Lists_Test.TimeOutName)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var result: [Int] = self.helper2(Hard_023_Merge_K_Sorted_Lists.mergeKLists(input))
            assertHelper(expected == result, problemName: Hard_023_Merge_K_Sorted_Lists_Test.ProblemName, input: input, resultValue: result, expectedValue: expected)
            expectation.fulfill()
        })
        waitForExpectationsWithTimeout(Hard_023_Merge_K_Sorted_Lists_Test.TimeOut) { (error: NSError!) -> Void in
            if error != nil {
                assertHelper(false, problemName: Hard_023_Merge_K_Sorted_Lists_Test.ProblemName, input: input, resultValue: Hard_023_Merge_K_Sorted_Lists_Test.TimeOutName, expectedValue: expected)
            }
        }
    }
}