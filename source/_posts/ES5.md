---
title: ES5
date: 2019-05-01 12:56:46
tags: js
categories: 前端
---

### ES5新增语法

##### 严格模式

1. 理解

   ES5新增了第二种运行模式：严格模式。在这种模式下，使得JavaScript在更加严格的语法条件下运行

2. 目的/作用

   消除js语法的一些不合理、不严谨之处，减少一些怪异行为。

   消除代码的一些不安全之处。

3. 使用

   在全局或函数的第一条语句定义：`'use strict'`。

   如果浏览器不支持，则会被解析为一条简单的语句，不会产生副作用。

4. 语法和行为

   变量在使用前，必须先声明。

   禁止自定义函数中的this指向window

   创建eval作用域

   对象不能有重名属性

##### JSON对象

1. 新增JSON.stringify(obj/arr)

   js对象（数组）转换为json对象（数组）

   ```js
   //将js对象转换为JSON对象输出
   var obj = {username: 'zhangsan'};
   console.log(JSON.stringify(obj)); // '{"username":"zhangsan"}'
   
   //将js数组转换为JSON数组输出
   var array = [1,2,3];
   console.log(JSON.stringify(array)); //'[1,2,3]'
   ```

2. 新增JSON.parse(json)

   json对象（数组）转换为js对象（数组）

   ```js
   //将JSON对象转换为js对象
   var jsonObj = '{"username":"zhangsan"}';
   console.log(JSON.parse(jsonObj)); //{username: 'zhangsan'}
   
   //将JSON数组转换为js数组
   var jsonArray = '[1,2,3]';
   console.log(JSON.parse(jsonArray)); //[1,]
   ```

##### object的扩展

1. Object.create(prototype,[descriptors])

   - 作用：以指定对象为原型创建新的对象
   - 为新的对象指定新的属性，并对属性进行描述
     - value：指定值
     - writable：标识当前新增的属性值是否是可修改的，默认为false
     - configurable：标识当前新增的属性是否可以被删除，默认为false
     - enumerable：标识当前新增的属性是否能够用for in枚举，默认为false

   ```js
   var obj1 = {username: 'zhangsan'};
   var obj2 = Object.create(obj1);
   console.log(obj2); // 输出为{},obj1对象被指定为obj2.__proto__属性中
   console.log(obj2.__proto__); //{username:'zhangsan'}
   var obj3 = Object.create(obj1,{
       sex: {
           value: '男',
           writable: true //表示当前属性值可以被修改
       },
       age: {
           value: 20,
           enumerable: true //表示当前属性可被for in枚举
       }
   })
   ```

2. Object.defineProperties(object,descriptors)

   - 作用：为指定对象定义扩展多个属性
   - get：用来获取当前属性值的回调函数
   - set：修改当前属性值的触发的回调函数，并且实参即为修改后的值
   - 存储器属性：setter，getter一个用来存值，一个用来取值

   ```js
   var obj2 = {firstName: 'kobe', lastName: 'brant'};
   Object.defineProperties(obj2,{
       fullName: {
           get: function (){ //获取对象扩展属性的值，获取扩展属性时get方法自动调用
           	return this.firstName + " " + this.lastName;
       	},
           set: function (data){ //监听扩展属性的值，当扩展属性值发生变化时，自动调用当前函数
               //data值为当前属性被更新后最新的值
               var names = data.split(' ');
               this.firstName = names[0];
               this.lastName = names[1];
           }
       }
   })
   console.log(obj2.fullName); //'kobe brant' 调用fullName的get方法
   obj2.fullName = 'tim duck'; //此时将会触发调用fullName属性中的set方法
   console.log(obj2.fullName); //'tim duck' 调用fullName的get方法
   ```

   > 对象本身的两个方法
   >
   > - get propertyName(){}用来得到当前属性值的回掉函数
   >
   > - set propertyName(){}用来监视当前属性值变化的回掉函数
   >
   >   ```js
   >   var obj = {
   >       firstName: 'curry',
   >       lastName: 'step',
   >       get fullName() { //固定写法，需要省略function,get类似function作用
   >           return this.firstName + ' ' + this.lastName;
   >       },
   >       set fullName(data) {
   >           var names = data.split(' ');
   >           this.firstName = names[0];
   >           this.lastName = names[1];
   >       }
   >   }
   >   ```
   >

##### Array扩展

1. Array.prototype.indexOf(value)：得到值在数组中的第一个下标

   ```js
   var arr = [1,2,3,4,5,2];
   console.log(arr.indexOf(2)); //1
   ```

2. Array.prototype.lastIndexOf(value)：得到值在数组中的最后一个下标

   ```js
   var arr = [1,2,3,4,5,3];
   console.log(arr.lastIndexOf(3)); //5
   ```

3. Array.prototype.forEach(function(item,index){})：遍历数组

   ```js
   var arr = [1,2,3,4,5];
   arr.forEach(function(item,index) {
       console.log(item,index);
   })
   ```

4. Array.prototype.map(function(item,index){})：遍历数组返回一个新的数组，返回加工之后的值

   ```js
   var arr = [1,2,3,4,5];
   var arr2 = arr.map(function(item,index){
       return item + 1;
   })
   console.log(arr2); //[2,3,4,5,6]
   ```

5. Array.prototype.filter(function(item,index){})：遍历过滤出一个新的子数组，返回条件为true的值

   ```js
   var arr = [1,2,3,4,5];
   var arr2 = arr.filter(function(item,index){
       return item > 3
   })
   console.log(arr2); //[4,5]
   ```

##### Function扩展

1. Function.prototype.bind(obj)：
   - 作用：将函数内的this绑定obj，并将函数返回
2. 区别bind()与call()和apply()？
   - 都能指定函数中改的this
   - call()/apply()是立即调用函数
   - bind()是将函数返回
   - 传入参数形式：
     - foo.call(obj,33)  //直接传入第二个参数
     - foo.apply(obj,[33]) //第二个参数必须是数组，传入放在数组里
     - bind特点：绑定完this不会立即调用当前的函数，而是将函数返回

