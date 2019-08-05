---
title: 编写可维护的JavaScript笔记
date: 2019-06-01 11:52:38
tags: axios
categories: 读书笔记
---

### 换行
逗号也是运算符，例如下面，逗号应该作为前一行的结尾。如果把它放在第二行的开始，自动分号插入机制会在某些场景下在前一行结束的位置自动插入分号，导致错误发生。

```js
//好的代码风格

function(document, element, window, strings, navigator,
div_somediv) {

    // Here is some code 
}

//不好的代码风格

function(document, element, window, strings, navigator
, div_somediv) {

    // Here is some code
}

```
### 注释
单行注释应该有一个空行。多行注释最好如下所示进行标注以及缩进

```js
function(document, element, window, strings) {
    
    // 单行注释
    fun(document, window);
}

function(document, element) {
    /*
     * 这里是多行注释
     * 星号后面有个空格
     */
     console.log(document);
}
```
### 花括号的对齐方式
对于JavaScript，花括号最好放在块语句中第一句代码的末尾，原因就是对于换行规范的解释：避免错误的分号自动插入。Google JavaScript风格指南明确禁止将花括号放在块语句首行的下一行：


```js
// 推荐的做法
if (condition) {
    doSomething();
}else {
    doSomething();
}

// 不好的做法
if (condition)
{
    doSomething();
}
else 
{
    doSomething();
}
```
### switch的default
如果`switch`的`default`分支什么也不做，可以省略掉default，因为这可以节省一些字节。
### for-in 循环
for-in循环遍历相对来说是比较慢的，主要用来“枚举”对象的属性，不应用来遍历数组。
for-in循环会把对象的全部属性--包括从原型继承的属性都遍历出来，如果想要去除这些原型上的属性，可以使用`hasOwnProperty()`方法为`for-in`循环过滤出实例属性。

```js
var obj = {name: 'Tom', age: 20};
for (prop in obj) {

// 通过hasOwnProperty判断
    if(obj.hasOwnProperty(prop)) {
    
    // 此时prop不包含原型中的属性
        console.log(prop);
    }
```
### 变量声明和函数声明
1. 总数将局部变量的定义作为函数内第一条语句
2. 使用单`var`语句--每个变量的初始化独占一行；对于那些没有进行初始化的变量，它们应当出现在`var`语句的尾部。
3. 哪怕是写在for循环里临时使用的变量，也最好放到函数顶部的变量语句中。
4. 函数声明不应当出现在语句块之内。（这个只针对使用`var`语句来声明的变量，对于es6的`let`语句，有自己独立的作用域）

### 原始包装类型
JavaScript有三种原始包装类型：`String`、`Boolean`、`Number`。每种类型都代表全局作用域中的一个构造函数，并分别表示各自对应的原始值的对象。

```js
var name = 'Tom';
name.author = 'Jack';
console.log(name.author); // undefined
```
第二行，js引擎会根据name的上下文类型临时创建了`String`对象，为这个临时对象添加了autor属性，当执行完后，临时`String`对象就被销毁了。

*不推荐使用`new`关键字来创建原始包装类型对象*

### 将CSS从js中抽离
js不应直接操作样式，以便保持和CSS的松耦合。在js中将样式添加至元素的几种方法：

```js
// 好的写法 - 原生js
element.className += ' active';

// 好的写法 - HTML5
element.classList,add('active');

// 好的写法 - jQuery
$(element).addClass('active');

// 好的写法 - YUI
Y.one(element).addClass('active');

// 好的写法 -Dojo
dojo.addClass(element, 'active');
```

### 单全局变量模式
单全局变量模式已经在各种流行的js类库中广泛的应用了。
单全局变量模式是指，在整个上下文中，只创建一个全局变量；它不会和内置的API冲突，并将你所有的功能代码都挂载到这个全局对象上。