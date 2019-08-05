---
title: js的prototype总结
date: 2018-10-06 17:40:45
tags: js
categories: 前端
---

### js的prototype总结

**1. 每一个函数都有一个`prototype`，即原型**。

**2. 每个对象都有一个`__proto__`，可称为隐式原型，指向创建该对象的函数的`prototype`。**

> **`Object.prototype`却是一个特例——它的`__proto__`指向的是`null`。**

![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/06/3ed52e91409ae13e805e9ea9c771c66c.png)

**3. 自定义函数`Foo.__proto__`指向`Function.prototype`,`Object.__proto__`指向`Function.prototype`，而`Function.__proto__`指向`Function.prototype`,从而形成一个环形结构。`Function`也是一个函数，函数是一种对象，而`Function`是被自身所创建的一种函数，所以它的`__proto__`指向了自身的`prototype`。**

![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/06/672e52454044214b80a9d2f140417535.png)

**4. `Function.prototype`是一个对象，它的`__proto__`也指向`Object.prototype`。**

![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/06/fc61390740d130488051d1089074ba12.png)

**5. `Instanceof`运算符：**

> `instanceof`运算符的左边的变量是一个对象，暂时称为A；右边的变量为一个函数，暂时称为B。
>
> **`instanceof`的判断规则：沿着A的`__proto__`这条线来找，同时沿着B的`prototype`这条线来找，如果两条线能够找到同一个引用，也就是同一个对象的话，返回`true`，如果找到终点还未重合，则返回`false`。**

```javascript
function Foo(){};
let f1=new Foo();
console.log(f1 instanceof Foo); //true
console.log(f1 instanceof Object); //true
```

![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/06/ad023c9f40a1e17f803967a5a402683e.png)

***`instanceof`表示的就是一种继承关系，或者原型链的结构。***

![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/19/fb2ec26540658c9480e22f7217f7ff29.png)