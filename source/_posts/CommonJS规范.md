---
title: CommonJS规范
date: 2018-12-09 12:12:08
tags: 模块开发规范
categories: 前端
---

### **CommonJS规范**

**CommonJS对模块的定义十分简单，主要分为模块引用、模块定义和模块标识3部分。**

1. 模块引用

   ```js
   var math = require('math');
   ```

   在CommonJS规范中，存在`require()`方法，这个方法接受模块标识，以此引入一个模块得API到当前上下文中。

2. 模块定义

   上下文提供了exports对象用于导出当前模块的方法或者变量，并且它是唯一导出的出口。在模块中还存在一个`module`对象，它代表模块自身，而`exports`是`module`的属性。在Node中，一个文件就是一个模块，将方法挂载在`exports`对象上作为属性即可定义导出的方式。

   ```js
   //math.js
   exports.add=function(){
       var sum=0,
           i=0,
           args=arguments,
           l=args.length;
       while(i<l){
           sum+=args[i++];
       }
       return sum;
   }
   ```

   在另一个文件中，我们可以通过`require()`方法引入模块后，就能调用定义的属性或方法。

   ```js
   //program.js
   var math=require('math');
   exports.increment=function(val){
       return math.add(val,1);
   }
   ```

3. 模块标识

   模块标识其实就是传递给`require()`方法的参数，它必须是符合小驼峰命名的字符串，或者是.、..开头的相对路径，或者绝对路径。可以没有文件的后缀名.js。

   模块的定义十分简单，接口十分简洁。它的意义在于将方法和变量等限定在私有的作用域中，同时支持引入和导出功能，每个模块具有独立的空间，它们互不干扰。

##### 包规范

1. 包结构

   主要用于组织包中的各种文件。

2. 包描述文件与NPM

   用于描述包的相关信息，以供外部读取分析。

如果要输出一个键值对象`{}`，可以利用`exports`这个已存在的空对象`{}`，并继续在上面添加新的键值；

如果要输出一个函数或数组，必须直接对`module.exports`对象赋值。

所以我们可以得出结论：直接对`module.exports`赋值，可以应对任何情况：

```js
module.exports = {
    foo: function () { return 'foo'; }
};
```

或者：

```js
module.exports = function () { return 'foo'; };
```

最终，我们*强烈建议*使用`module.exports = xxx`的方式来输出模块变量，这样，你只需要记忆一种方法。