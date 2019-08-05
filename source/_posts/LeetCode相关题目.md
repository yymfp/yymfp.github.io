---
title: LeetCode相关题目
date: 2019-03-10 22:18:31
tags: 算法
categories: 前端
---

### 两个数之和

给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

示例:

给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9

所以返回 [0, 1]

```js
var twoSum = function(nums, target) {
    let hashMap = new Map()
  // 初始化hashMap
  for (let i = 0; i < nums.length; i++) {
    if (!hashMap.has(nums[i])) {
      hashMap.set(nums[i], i)
    }
  }
  for (let i = 0; i < nums.length; i++) {
    let diff = target - nums[i]
    if (hashMap.has(diff) && hashMap.get(diff) !== i) {
      return [i, hashMap.get(diff)]
    }
  }
};
```



### 反转链表

反转一个单链表。

示例:

输入: 1->2->3->4->5->NULL

输出: 5->4->3->2->1->NULL

迭代方法：

```js
function ListNode(val) {
    this.val = val;
    this.next = null;
}

var reverseList = function(head) {
    if(head === null) {
        return null
    }
    let p = head;
    let q = head;  
    while(head.next != null) {
        p = head.next;
        head.next = p.next;
        p.next = q;
        q = p; //用来保存下次指针指向的位置
    }
    return q
};
```

递归方法：

```js
let p = null;
let q;
var reverse = function(head) {
    if(head === null) {
        return null
    }
    if(head.next === null) {
        p = head
        return head
    }
    q = reverse(head.next);
    q.next = head;
    head.next = null;
    return head
}

var reverseList = function(head) {
    reverse(head);
    return p
}
```