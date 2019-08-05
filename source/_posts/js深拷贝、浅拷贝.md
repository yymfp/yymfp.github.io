---
title: js深拷贝、浅拷贝
date: 2019-06-01 11:27:05
tags: js
categories: 前端
---

### js深拷贝、浅拷贝

什么是深拷贝？深拷贝和浅拷贝有什么区别？

浅拷贝是指只复制第一层对象，但是当对象的属性是引用类型时，实质复制的是其引用，当引用指向的值改变时也会跟着变化。

深拷贝复制变量值，对于非基本类型的变量，则递归至基本类型变量后，再复制。深拷贝后的对象与原来的对象是完全隔离的，互不影响，对一个对象的修改并不会影响另一个对象。

实现一个深拷贝:

```js
function deepClone(obj) {
    if(obj === null) {return null}; // null情况
    if(obj instanceof RegExp) {return new RegExp(obj)};
    if(obj instanceof Date) {return new Date(obj)};
    
    // 如果不是复杂数据类型，直接返回
    if(typeof obj !== 'object') {
        return obj
    }
    
    // 如果obj是数组，那么obj.constructor是[Function: Array]
    // 如果obj是对象，那么obj.constructor是[Function: Object]
    
    let t = new obj.constructor(); // [] or {}
    for(let key in obj) {
        t[key] = deepClone(obj[key]) // 复杂数据类型进行递归
    }
}
```

