---
title: NodeJs事件轮询机制
date: 2019-04-26 14:53:19
tags: NodeJS
categories: 前端
---

### NodeJs 事件轮询机制

NodeJs的事件轮询机制是借助libuv库实现的。

概括事件轮询机制可分为六个阶段：

1. timers定时器阶段：计时和执行到点的定时器回掉函数
2. pending callbacks：某些系统操作（例如TCP错误类型）的回调函数
3. idle，prepare：准备工作
4. poll轮询阶段（轮询队列）：
   - 如果轮询队列不为空，依次同步取出轮询队列中第一个回调函数执行，直到轮询队列为空或者达到系统最大限度。
   - 如果轮询队列为空
     1. 如果之前设置过setImmediate函数，则直接进入下一个check阶段
     2. 如果之前没有设置setImmediate函数，在当前poll阶段等待，直到轮询队列添加回调函数，就去第一个情况执行。或者等到定时器到点了，也会去下一个阶段
5. check查阶段：执行setImmediate设置的回调函数。
6. close callbacks 关闭阶段：执行close事件回调函数

process.nextTick能在任意阶段优先执行