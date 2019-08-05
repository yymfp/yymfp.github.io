---
title: js宏任务和微任务
date: 2019-04-28 11:03:51
tags: js
categories: 前端
---

### js宏任务和微任务

##### 宏任务

分类：`setTimeout` `setInterval` `requrestAnimationFrame`

1. 宏任务所处的队列就是宏任务队列
2. 第一个宏任务队列中只有一个任务：执行主线程的js代码
3. 宏任务队列可以有多个
4. 当宏任务队列中的任务全部被执行完以后会查看是否有微任务队列如果有则先执行微任务队列中的所有任务，如果没有就查看是否有宏任务队列

##### 微任务

分类：`new promise.then(回调)` `process.nextTick`

1. 微任务所处的队列就是微任务队列
2. 只有一个微任务队列
3. 在上一个宏任务队列执行完毕后如果有微任务队列就会执行微任务队列中的所有任务 

```js
console.log('---------- start --------------');
setTimeout(() => {
    console.log('setTimeout');
}, 0)

new Promise((resolve, reject) => {
    for(var i = 0; i < 5; i++) {
        console.log(i);
    }
    resolve(); //修改promise实例对象的状态为成功的状态
}).then(() => {
    console.log('promise实例成功回调执行！');
})
console.log('------------- end ----------------');



//输出结果
/*
---------- start --------------
0
1
2
3
4
------------- end ----------------
promise实例成功回调执行
setTimeout
*/
```

