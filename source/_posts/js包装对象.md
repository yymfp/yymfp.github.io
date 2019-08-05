---
title: js包装对象
date: 2018-10-08 16:34:14
tags: js
categories: 前端
---

### js包装对象

在js中，对于基本的string、number、Boolean类型，在对其进行类似对象的操作时，会将这些基本类型包装成一个临时对象类型，例如：

```javascript
let srt="string";
console.log(str);	//"string"
console.log(str.length); //6
```

***说明：***定义一个变量，赋值为字符串'string'，本身是一个基本的string类型，在调用它的length时，会将其包装成一个临时的对象，用来获取相关属性。调用length属性之后，这个临时的对象会被立即销毁。

```javascript
console.log(str); //string
str.a=10;
console.log(str.a); //undefined
```

**给str添加a属性，添加完毕，包装对象立即被销毁，再去访问，得到undefined。**