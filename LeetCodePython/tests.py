import timeit
from queue import Queue
from unittest import TestCase
import json

import math

import sys


# Definition for singly-linked list.
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


class Tests(TestCase):
    def test_case(self):

        s = Solution()
        self.assertEqual(s.isValid('(())'), True)
        self.assertEqual(s.isValid('(()'), False)
        self.assertEqual(s.isValid('(([)])'), False)



class Solution:
    def buildTree(self, preorder, inorder):
        """
        :type preorder: List[int]
        :type inorder: List[int]
        :rtype: TreeNode
        """
