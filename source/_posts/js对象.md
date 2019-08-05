---
title: js对象
date: 2018-10-23 16:20:52
tags: js
categories: 前端
---

### js对象

- ##### 创建对象的方式


1. 通过字面量方式创建

   ```js
   var Person={}; //相当于var Person=new Object()
   var Person={
       name:'张三',
       age:20
   }
   ```

2. 通过Object构造函数

   ```js
   var Person=new Object();
   Person.name="张三";
   Person.age=20;
   ```

3. 工厂模式

   ```js
   function cretPerson(name,age){
       var o=new Object();
       o.name=name;
       o.age=age;
       o.say=function(){
           console.log(this.name+': '+this.age);
       }
       return o;
   }
   var person1=cretPerson('张三',20);
   ```

4. 构造函数

   ```js
   function Person(name,age){
       this.name=name;
       this.age=age;
       this.say=function(){
           console.log(this.name+': '+this.age);
       }
   }
   var person1=new Person('张三',20);
   ```

5. 原型模式

   ```js
   function Person(){};
   Person.prototype.name='张三';
   Person.prototype.age=20;
   Person.prototype.say=function(){
       console.log(this.name+': '+this.age);
   }
   var person1=new Person();
   ```

6. 使用ES5的Object.create()

   ```js
   const Person = {
     	name:'张三',
       age:20
   };
   var person1 = Object.create(Person);
   
   function Person(){};
   var person2 = Object.create(Person);
   ```

7. 使用Class关键字

   ```js
   class Person(name,age){
       this.name=name;
       this.age=age;
       this.say=function(){
           console.log(this.name+': '+this.age);
       }
   }
   var person1=new Person();
   ```

   ##### Object.create()和new的异同

   1. new：

      - 创建新对象
      - 将相关属性和this绑定到新对象上
      - 将新创建的对象的原型(`__proto__`)指向构造函数的原型(`prototype`)

   2. Object.create()：

      > 语法：`Object.create(proto, [propertiesObject])`

      - 创建一个空对象
      - 如果[propertiesObject]存在，则是要添加到新创建对象的可枚举属性（即其自身定义的属性，而不是其原型链上的枚举属性）对象的属性描述符以及相应的属性名称
      - 将新创建的对象的原型(`__proto__`)指向参数proto本身。（这里是参数proto，而不是proto.prototype）

| 比较     | new                     | Object.create           |
| -------- | ----------------------- | ----------------------- |
| 构造函数 | 保留原构造函数属性      | 丢失原构造函数属性      |
| 原型链   | 原构造函数prototype属性 | 原构造函数/（对象）本身 |
| 作用对象 | function                | function和object        |

```js
function o(){};
var a=new o();
var b=Object.create(o);
console.log(a.__proto__===o.prototype); //true    new创建的对象的原型指向构造函数的原型
console.log(b.__proto__===o); //true Object.create创建的对象的原型指向构造函数o本身
console.log(b.__proto__); //f o(){}
```

##### 使用`Object.create`的`propertyObject`参数

```js
function o(){};
var b=Object.create(o,{name:{value:'张三'}});
console.log(b); //Function {name: "张三"}
```

- **对象枚举**

  for in 语句可以用来遍历一个对象中所有的属性名，该枚举过程将会列出所有的属性—包括函数和你可能不关心的原型中的属性---所以有必要过滤掉那些你不想要的值。通常使用的过滤器是`hasOwnProperty`方法，以及使用`typeof`来排除函数。

  原型链中的任何属性通过typeof判断：

  ```js
  typeof obj.toString    // 'function'
  typeof obj.constructor  // 'function'
  ```

  ```js
  var name;
  //通过typeof来排除原型中的属性
  for(name in obj) {
      if(typeof obj[name] !== 'function') {
          //执行其他
      }
  }
  //通过hasOwnProperty来排除原型中的属性
  for(name in obj) {
      if(obj.hasOwnProperty(name)) {
          //执行其他
      }
  }
  ```

  在使用for in 遍历对象时，属性名出现的顺序是不确定的。如果想要确保属性以特定的顺序出现，最好的办法就是避免使用for in 语句，而是创建一个数组，在其中以正确的顺序包含属性名。

  ```js
  var i;
  var properties = [
      'first-name',
      'middle-name',
      'last-name',
      'profession'
  ]
  for(i = 0; i < properties.length; i += 1) {
      obj[properties[i]];
  }
  ```

- 删除对象中的属性

  `delete`运算符可以用来删除对象的属性。它将会移除对象中确定包含的属性，它不会触及原型链中的任何对象。删除对象的属性可能会让来自原型链中的属性浮现出来。

**new的原理**

new：

1. 创建一个新对象
2. 对这个新对象执行原型连接
3. 属性和方法被加入到this引用的对象中，并执行构造函数中的方法
4. 如果函数没有返回其他对象，那么this指向这个新对象，否则this指向构造函数中返回的对象

```js
function new(func) {
    let target = {};
    target.__proto__ = func.prototype;  // 原型连接
    let res = func.call(target);  // 将新对象作为this指向执行构造函数，并获取返回结果
    if (res && typeof(res) == "object" || typeof(res) == "function") {  // 判断返回结果是否有其他对象，如果有则返回
    	return res;
    }
    return target;
}
```

