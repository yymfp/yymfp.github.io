---
title: JavaScript高级程序设计笔记
date: 2019-06-01 11:51:41
tags: js
categories: 读书笔记
---

### async
javaScript标签上添加async以及defer属性时，只针对外部引入的js文件。确保相关的js代码依赖问题。

在使用async时，不要在此期间操作dom。

### undefined == null 返回 true
undefined的值是派生自null值的。

由于typeof null会返回object，所以在定义变量用来保存对象，最好将变量初始化为null而不是其他的值。
```javascript
if (car != null){
// 对 car 对象执行某些操作
}
```
### 函数传参

> ECMAScript 中的所有参数传递的都是值，不可能通过引用传递参数。


```js
// 引用类型参数传递

	let obj = {name:'zhangsan',age:20};
	function getName(args) {
		args.name = 'lisi';
		args = new Object();
		args.name = 's';
	}
	getName(obj);
	console.log(obj);  // {name:'lisi',age:20}
	
// 基本数据类型参数

	let s = 'zhangsannnnn';
	function changeName(args) {
		args = 'hahha';
	}
	changeName(s);
	console.log(s);  // zhangsannnnn

```
> 在向参数传递基本类型的值时，被传递的值会被复制给一个局部变量(即命名参数，或者用 ECMAScript 的概念来说，就是 arguments 对象中的一个元素)。在向参数传递引用类型的值时，会把 这个值在内存中的地址复制给一个局部变量，因此这个局部变量的变化会反映在函数的外部。
> ***可以把** ECMAScript 函数的参数想象成局部变量。*

- 对于基本类型的参数传递，相当于在函数内部直接复制一份，虽然值一样，确实两个独立的内存空间。
- 对于引用类型参数传递，也是将传递的是当前引用变量所保存的内存地址的值复制一份。所以在修改操作相关属性时，会影响到外部变量。而对其进行重新赋值时，会改变函数内部新复制的局部变量的值，并不会影响到外部变量的指向问题。

### Function类型

> 每个函数都是Function类型的实例，而且都与其他引用类型一样具有属性和方法。由于函数是对象，因此函数名实际上也是一个指向函数对象的指针，并不会与某个函数绑定。函数一般都是使用函数声明语法定义的。


```js
function sum (num1, num2) {
    return num1 + num2;
}
```
这与下面使用函数表达式定义函数的方式几乎相差无几。


```js
var sum = function(num1, num2) {
    return num1 + num2;
}
```
**不推荐使用Function构造函数，Function构造函数可以接收任意数量的参数，但最后一个参数始终都被看成是函数体，儿前面的参数则枚举出了新函数的函数参数。**


```js
var sum = new Function("num1", "num2", "return num1 + num2"); // 不推荐
```
> 不推荐这种方式创建函数，因为这种语法会导致解析两次代码（第一次是解析常规ECMAScript代码，第二次是解析传入构造函数中的字符串，调用解析器对性能损耗较大），从而影响性能。不过，这种语法对于理解”函数是对象，函数名是指针“的概念比较直观。

函数名仅仅是指向函数的指针：


```js
function sum(num1, num2) {
    return num1 + num2;
}
console.log(sum(10,10));  // 20
let anotherSum = sum;
console.log(anotherSum(10,10));  // 20
sum = null;
console.log(anotherSum(10,10));  // 20
```
### 函数声明与函数表达式

解析器在向执行环境中加载数据时，对函数声明和函数表达式并非一视同仁。解析器会率先读取函数声明，并使其在执行任何代码之前可用；而函数表达式，则必须等到解析器执行到它所在的代码行，才会真正被解释执行。


```js
console.log(sum(10, 10));  // 20
function sum(sum1, sum2) {
    return num1 + num2
}
```
> 以上代码完全可以正常运行，因为在代码开始执行之前，解析器就已经通过一个名为函数声明提升的过程，读取并将函数声明添加到执行环境中。对代码求值时，js引擎在第一遍会声明函数并将它们放到源代码树的顶部。所以，及时声明函数的代码在调用它的代码后面，js引擎也能把函数声明提升到顶部。


```js
console.log(sum(10,10)); // 报错
var sum = function(num1, num2) {
    return num1 + num2;
}
```
> 以上代码会在运行期间产生错误，原因在于函数位于一个初始化语句中，而不是一个函数声明。在执行到函数所在的语句之前，变量sum中不会保存有对函数的引用。

**除了什么时候可以通过变量访问函数这一点区别之外，函数声明与函数表达式的语法其实是等价的。**

### 函数内部属性

> 在函数内部，有两个特殊的对象：arguments和this。arguments是一个类数组对象，包含着传入函数中的所有参数。虽然arguments的主要用途是保存函数参数，但这个对象还有一个名叫callee的属性，该属性是一个指针，指向拥有这个arguments对象的函数。

```js
// 定义一个阶乘函数
function factorial(num) {
    if(num <= 1) {
        return 1;
    }else {
        return num * factorial(num - 1)
    }
}
```
定义阶乘函数一般都要用到递归算法；如上面的代码所示，在函数有名字，而且名字以后也不会变得情况下，这样定义没有问题。但问题是这个函数的执行与函数名factorial紧紧耦合在了一起，为了消除这种紧密耦合的现象，可以向下面这样使用arguments.callee：

```js
function factorial(num) {
    if(num <= 1) {
        return 1;
    }else {
        return num * arguments,callee(num - 1)
    }
}

/*
    在这个重写后的factorial()函数的函数体内，没有再引用函数名factorial。这样，无论引用函数时使用的是什么名字，都可以保证正常完成递归调用。
*/

var trueFactorial = factorial;

factorial = function() {
    return 0;
}

console.log(trueFactorial(5));  // 120
console.log(factorial(5));  // 0
```

### 函数属性和方法

> 每个函数都包含两个属性：length和prototype。length属性表示函数希望接收的命名参数的个数。


```js
function sayName(name) {
    console.log(name);
}
function sum(num1, num2) {
    return num1 + num2
}
function sayHi() {
    console.log("hi");
}

console.log(sayName.length);  // 1
console.log(sum.length);      // 2
console.log(sayHi.length);    // 0
```

相关方法使用：

- trim方法：会创建一个字符串的副本，删除前置及后缀的所有空格，然后返回结果。
- random方法：Math.random方法返回大于等于0小于1的一个随机数。

```js
值 = Math.floor(Math.random() * 可能值的总数 + 第一个可能的值)

// 如果你想选择一个1到10之间的数值：
var num = Math.floor(Math.random() * 10 + 1);

// 一个介于2到10之间的值：
var num = Math.floor(Math.random() * 9 + 2);

function selectFrom(lowerValue, upperValue) {
    var choices = upperValue - lowerValue + 1;
    return Math.floor(Math.random() * choices + lowerValue);
}
var num = selectFrom(2, 10);
console.log(num); // 介于2和10之间(包括2和10)的一个数值

```
### 对象属性和方法

**通过字面量方式定义对象**
```js
var person = {
    name: 'Bar',
    age: 20,
    sayName: function() {
        console.log(this.name);
    }
}
```

1. 数据属性
> 数据属性包含一个数据值得位置。在这个位置可以读取和写入。数据属性有四个描述其行为的特性。

- [[Configurable]]： 表示能否通过delete删除属性从而重新定义属性，能否修改属性的特性，或者能否把属性修改为访问器属性。像前面通过字面量直接在对象上定义的属性，它们的这个特性默认值为true。
- [[Enumerable]]：表示能否通过for-in循环返回属性。像前面例子那样直接在对象上定义的属性，它们的这个特性默认值为true。
- [[Writable]]：表示能否修改属性的值。像前面例子中那样直接在对象上定义的属性，它们的这个特性默认值为true。
- [[Value]]：包含这个属性的数据值。读取属性值得时候，从这个位置读；写入属性值的时候，把新值保存在这个位置。这个特性默认值为undefined。

要修改属性默认的特性，必须使用ECMAScript5的Object.defineProperty()方法。这个方法接收三个参数：属性所在对象、属性的名字和一个描述符对象。其中，描述符对象属性必须是：configurable、enumerable、writable和value。设置其中一个或多个值，可以修改对应的特性值。例如：
```js
var person = {};
Object.defineProperty(person, "name", {
    writable: false,  // 不可以修改属性的值
    value: "Bar"
});
console.log(person.name);  // Bar
person.name = "Jack";
console.log(person.name);  // Bar
```
把configurable设置为false，表示不能从对象中删除属性。如果对这个属性调用delete，则在非严格模式下什么也不会发生，而在严格模式下会导致错误。**而且，一旦把属性定义为不可配置的，就不能再把它变回可配置了。**此时，再调用Object.defineProperty()方法修改除了writable之外的特性，都会导致错误：
```js
var person = {};
Object.defineProperty(person, "name", {
    configurable: false,
    value: "Bar"
})

// 抛出错误
Object.defineProperty(person, "name", {
    configurable: true,
    value: "Bar"
})

// 也就是说，可以多次调用Object.defineProperty()方法修改统一属性，但在把configurable特性设置为false之后就会有限制了。
```
2. 访问器属性
> 访问器属性不包含数据值；它们包含一对儿getter和setter函数（不是必须的）。在读取访问器属性时，会调用getter函数，这个函数负责返回有效的值；在写入访问器属性时，会调用setter函数并传入新值，这个函数负责决定如何处理数据。访问器属性有以下4个特性。
- [[Configurable]]：表示能否通过delete删除属性从而重新定义属性，能否修改属性的特性，或者能否把属性修改为数据属性。
- [[Enumerable]]：表示能否通过for-in循环返回属性。
- [[Get]]：在读取属性时调用的函数。
- [[Set]]：在写入属性时调用的函数。

同样的，访问器属性也不能直接定义，必须使用Object.defineProperty()来定义。
```js
var book = {
    _year: 2004,
    edition: 1
};

Object.defineProperty(book, "year", {
    get: function() {
        return this._year;
    },
    set: function(newValue) {
        if(newValue > 2004) {
            this._year = newValue;
            this.edition += newValue - 2004;
        }
    }
})
book.year = 2005;
console.log(book.edition);  // 2
```
> 不一定非要同时指定getter和setter。只指定getter意味着属性是不能写，尝试写入属性会被忽略。在严格模式下会报错。在这个方法之前，要创建访问器属性，一般都使用两个非标准的方法：__defineGetter__()和__defineSetter__()。

```js
var book = {
    _year: 2004,
    edition: 1
};

//定义访问器的旧有方法
book.__defineGetter__("year", function() {
    return this._year;
});

book.__defineSetter__("year", function(newValue) {
    if(newValue > 2004) {
        this._year = newValue;
        this.edition += newValue - 2004;
    }
})
```
**由于为对象定义多个属性的可能性很大，ECMAScript5又定义了一个Object.defineProperties()方法。** 利用这个方法可以通过描述符一次定义多个属性。这个方法接收两个对象参数：第一个对象是要添加和修改其属性的对象，第二个对象的属性与第一个对象中要添加或修改的属性一一对应。
```js
var book = {};
Object.defineProperties(book, {
    _year: {
        value: 2004
    },
    edition: {
        value: 1
    },
    year: {
        get: function() {
            return this._year;
        },
        set: function(newValue) {
            if(newValue > 2004) {
                this._year = newValue;
                this.edition += newValue - 2004;
            }
        }
    }
})
```
### 创建对象
> **虽然Object构造函数或对象字面量都可以用来创建单个对象，但这些方式有个明显的缺点：使用同一个接口创建很多对象，会产生大量的重复代码。**
1. 工厂模式

```js
function createPerson(name, age, job) {
    var o = new Object();
    o.name = name;
    o.age = age;
    o.job = job;
    o.sayName = function() {
        console.log(this.name);
    }
    return o;
}

var person1 = createPerson("Bar", 20, "Software Engineer");
var person2 = createPerson("Greg", 27, "Doctor");

// 此函数能够根据接收的参数来构建一个包含所有必要信息的Person对象。可以无数次调用这个函数，而每次它都会返回一个包含三个属性一个方法的对象。
```
2. 构造函数模式
```js
function Person(name, age, job) {
    this.name = name;
    this.age = age;
    this.job = job;
    this.sayName = function() {
        console.log(this.name);
    }
}

var person1 = new Person("Bar", 20, "Software Engineer");
var person2 = new Person("Greg", 27, "Doctor");
```

**特点：**

- 没有显式的创建对象；
- 直接将属性和方法赋给了this对象；
- 没有return语句；
- 函数名Person使用的是大写字母开头；

要创建Person的新实例，必须使用new操作符。以这种方式调用构造函数实际上会经历以下4个步骤：

- 1. 创建一个新对象
- 2. 将构造函数的作用域赋给新对象（因此this指向的就是新对象）
- 3. 执行构造函数中的代码（为这个新对象添加属性）
- 4. 返回新对象

*前面例子中，person1和person2分别保存着Person的一个不同的实例。这两个对象都有一个constructor（构造函数）属性，该属性指向Person*

```js
console.log(person1.constructor === Person);  // true
console.log(person2.constructor === Person);  // true
```
##### 构造函数的问题

> 使用构造函数的主要问题，就是每个方法都要在每个实例上重新创建一遍。在前面的例子中，person1和person2都有一个名为sayName()的方法，但那两个方法不是同一个Function的实例。不要忘了-------ECMAScript中的函数是对象，因此每定义一个函数，也就是实例化了一个对象。

```js
function Person(name, age, job) {
    this.name = name;
    this.age = age;
    this.job = job;
    this.sayName = new Function("console.log(this.name)"); // 与声明函数在逻辑上是等价的
}

// 不同实例上的同名函数是不相等的

console.log(person1.sayName == person2.sayName);  //false
```
创建两个完全同样任务的Function实例的确没有必要。况且有this对象在，根本不用再执行代码前就把函数绑定到特定对象上面。

```js
function Person(name, age, job) {
    this.name = name;
    this.age = age;
    this.job = job;
    this.sayName = sayName;
}
function sayName() {
    console.log(this.name);
}
```

##### 原型模式
```js
function Person() {}
Person.prototype.name = "Nicholas";
Person.prototype.age = 20;
Person.prototype.sayName = function() {
    console.log(this.name);
}

var person1 = new Person();
person1.sayName();  // Nicholas

var person2 = new Person();
person2.sayName();  // Nicholas
console.log(person1.sayName == person2.sayName);  //true
```

##### 原型与in操作符

有两种方式使用in操作符：单独使用和在for-in循环中使用。在单独的使用时，in操作符会在通过对象能够访问给定属性时返回true，无论该属性存在于实例中还是原型中。
```js
function Person(){
}
Person.prototype.name = "Nicholas";
Person.prototype.age = 29;
Person.prototype.job = "Software Engineer";
Person.prototype.sayName = function(){
    alert(this.name);
};
var person1 = new Person();
var person2 = new Person();
alert(person1.hasOwnProperty("name"));  //false
alert("name" in person1);  //true
person1.name = "Greg";
alert(person1.name); //"Greg" ——来自实例
alert(person1.hasOwnProperty("name")); //true
alert("name" in person1); //true
alert(person2.name); //"Nicholas" ——来自原型
alert(person2.hasOwnProperty("name")); //false
alert("name" in person2); //true
delete person1.name;
alert(person1.name); //"Nicholas" ——来自原型
alert(person1.hasOwnProperty("name")); //false
alert("name" in person1); //true
```

通过同时使用hasOwnProperty方法和in操作符，就可以确定该属性到底是存在于对象中，还是存在于原型中。

```js
function hasPrototypeProperty(object, name) {
    return !object.hasOwnProperty(name) && (name in object);
}

```
由于in操作符只要通过对象能够访问到属性就返回true，hasOwnProperty只在属性存在于实例中时才返回true，因此只要in操作符返回true而hasOwnProperty返回false，就可以确定属性是原型中的属性。