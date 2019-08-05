---
title: js类型检测总结
date: 2018-10-06 18:25:53
tags: js
categories: 前端
---

### js类型检测总结

**检测规则：**

![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/06/5e35a8e04062aeeb805a82c051a9560d.png)

1. **`typeof`：操作符返回一个字符串，表示未经计算的操作数的类型**

   语法：`typeof`运算符后跟操作数。

   >```javascript
   >typeof operand
   >or
   >typeof (operand)
   >```
   >
   >**operand是一个表达式，表示对象或原始值，其类型将被返回。**
   >
   >| 类型                                        | 结果                       |
   >| ------------------------------------------- | -------------------------- |
   >| Undefined                                   | `"undefined"`              |
   >| Null                                        | `"object"`                 |
   >| Boolean                                     | `"boolean"`                |
   >| Number                                      | `"number"`                 |
   >| String                                      | `"string"`                 |
   >| Symbol （ECMAScript 6 新增）                | `"symbol"`                 |
   >| 宿主对象（由JS环境提供）                    | *Implementation-dependent* |
   >| 函数对象（[[Call]] 在ECMA-262条款中实现了） | `"function"`               |
   >| 任何其他对象                                | `"object"`                 |

   ##### 使用`new`操作符：

   ```javascript
   let str=new String('string');
   let num=new Number(100);
   typeof str; //'object'
   typeof num; //'object'
   let func=new Function();
   typeof func; //'function'
   ```

   ##### 语法中需要括号：

   ```javascript
   let num=99;
   typeof num + ' str'; //it will return 'number str'
   typeof (num+' str'); //string
   ```

   ##### 暂存死区：

   > 在 ECMAScript 2015 之前，`typeof`总是保证为任何操作数返回一个字符串。但是，除了非提升，块作用域的[let](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let)和[const](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/const)之外，在声明之前对块中的`let`和`const`变量使用`typeof`会抛出一个[ReferenceError](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/ReferenceError)。这与未声明的变量形成对比，`typeof`会返回“undefined”。块作用域变量在块的头部处于“[暂时死区](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/let#Temporal_Dead_Zone_and_errors_with_let)”，直到被初始化，在这期间，如果变量被访问将会引发错误。
   >
   > ```
   > typeof undeclaredVariable === 'undefined';
   > typeof newLetVariable; let newLetVariable; // ReferenceError
   > typeof newConstVariable; const newConstVariable = 'hello'; // ReferenceError
   > ```
   >
   >

2. **`instanceof`：用于测试构造函数的`prototype`属性是否出现在对象的原型链中的任何位置**

> **语法：`object instanceof constructor`**
>
> **参数：`object` 要检测的对象， `constructor` 某个构造函数**
>
> **举例：**
>
> ```javascript
> function Dog(name,food){
>     this.name=name;
>     this.food=food;
>     console.log(this.name+'吃'+this.food);
> }
> let dog=new Dog('小黑','骨头');
> console.log(dog instanceof Dog); //true
> console.log(dog instanceof Object); //true
> ```

##### 描述：`instanceof`运算符用来检测`constructor.prototype`是否存在于参数`object`的原型链上。

```javascript
//定义函数
function A(){};
function B(){};

let o=new A();
o instanceof A; //true，因为o.__proto__指向A.prototype
o instanceof Object; //true,因为o.__proto__指向A.prototype，A.prototype指向Object.prototype

//继承
B.prototype=new A();
let o1=new B();
o1 instanceof B; //true
o1 instanceof A; //true，因为A.prototype在o1的原型链上
```

> 需要注意的是，如果表达式 `obj instanceof Foo` 返回`true`，则并不意味着该表达式会永远返回`true`，因为`Foo.prototype`属性的值有可能会改变，改变之后的值很有可能不存在于`obj`的原型链上，这时原表达式的值就会成为`false`。另外一种情况下，原表达式的值也会改变，就是改变对象`obj`的原型链的情况，虽然在目前的ES规范中，我们只能读取对象的原型而不能改变它，但借助于非标准的`__proto__`伪属性，是可以实现的。比如执行`obj.__proto__ = {}`之后，`obj instanceof Foo`就会返回`false`了。

##### `instanceof`和多全局对象（多个farme或多个window之间的交互）

> 在浏览器中，我们的脚本可能需要在多个窗口之间进行交互。多个窗口意味着多个全局环境，不同的全局环境拥有不同的全局对象，从而拥有不同的内置类型构造函数。这可能会引发一些问题。比如，表达式 `[] instanceof window.frames[0].Array` 会返回`false`，因为 `Array.prototype !== window.frames[0].Array.prototype`，并且数组从前者继承。

##### 演示`String`对象和`Date`对象都属于`Object`类型和一些特殊情况

下面的代码使用了`instanceof`来证明：`String`和`Date`对象同时也属于`Object`类型（他们是由`Object`类派生出来的）。

但是，使用对象文字符号创建的对象在这里是一个例外：虽然原型未定义，但`instanceof Object`返回`true`。

```javascript
var simpleStr = "This is a simple string"; 
var myString  = new String();
var newStr    = new String("String created with constructor");
var myDate    = new Date();
var myObj     = {};

simpleStr instanceof String; // 返回 false, 检查原型链会找到 undefined
myString  instanceof String; // 返回 true
newStr    instanceof String; // 返回 true
myString  instanceof Object; // 返回 true

myObj instanceof Object;    // 返回 true, 尽管原型没有定义
({})  instanceof Object;    // 返回 true, 同上
myNonObj instanceof Object; // 返回 false, 一种创建对象的方法，这种方法创建的对象不是Object的一个实例

myString instanceof Date; //返回 false

myDate instanceof Date;     // 返回 true
myDate instanceof Object;   // 返回 true
myDate instanceof String;   // 返回 false
```

- instanceof

  instanceof可以判断复杂数据类型，不能判断基本数据类型。
  
  instanceof实现原理是通过原型链进行查找。
  实现代码：
  
```js
    // L instanceof R
    function instance_of(L,R) { // L表示左表达式，R表示右表达式
        let O = R.prototype;  // R的显式原型
        L = L.__proto__;  // L的隐式原型
        while(true) {
            if(L === null) {  // Object.prototype.__proto__ --> null
                return false;
            }
            if(O === L) { // 判断全等时返回true
                return true;
            }
            L = L.__proto__;
        }
        
    }
```

**判断复杂类型**

```js
    Object.prototype.toString.call(Array); // [object Array]
```

