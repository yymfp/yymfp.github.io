---
title: js的this指向问题
date: 2018-10-22 19:22:01
tags: js
categories: 前端
---

### this总结

**一句话：谁调用的，this就指向谁。**

##### this分为以下的几种情况：

1. 全局的this（浏览器）

   ```js
   console.log(this.document===document); //true
   console.log(this===window); //true
   this.a=20;
   console.log(window.a); //20
   ```

2. 一般函数的this（浏览器）

   ```js
   this.b=10;
   function f(){
       console.log(this===window); //true
       console.log(this.b===window.b); //true
       console.log(this.b); //10
       console.log(window.b); //10
   }
   f();
   ```

3. 作为对象方法的函数的this

   ```js
   //例一
   var o={
       prop:10,
       f:function(){
           return this.prop;
       }
   }
   console.log(o.f()); //10
   
   //例二
   var o={prop:20};
   function p(){
       return this.prop;
   }
   o.f=p;
   console.log(o.f()); //20
   
   //例三
   var o={
       prop:30,
       f:function(){
           return this.prop;
       }
   }
   var f1=o.f;
   console.log(f1()); //undefined
   //如果f函数被赋值到另一个变量中，并没有作为对象o的属性被调用，那么this的指向就是window，this.prop就为undefined。
   ```

4. 对象原型链上的this

   ```js
   function f(){
       this.name="张三";
       this.age=20;
   }
   f.prototype.get=function(){
       console.log(this.name+': '+this.age);
   }
   var f1=new f();
   f1.get(); //张三：20
   ```

   **不仅仅是构造函数的prototype，即便是在整个原型链中，this代表的也是当前对象的值。**

5. get/set方法与this

6. 构造器中的this

   ```js
   function myClass(){
       this.a=20;
   }
   var o=new myClass();
   console.log(o.a); //20
   
   function myClass1(){
       this.a=20;
       return {a:10};
   }
   o=new myClass1();
   console.log(o.a); //10
   ```

7. call/apply方法与this

   ```js
   function add(c,d){
       return this.a+this.b+c+d;
   }
   var o={a:1,b:2};
   add.call(o,3,4); //1+2+3+4=10
   add.apply(o,[3,4]) //1+2+3+4=10
   function bar(){
       console.log(Object.prototype.toString.call(this));
   }
   bar.call(1); //"[object Number]"
   ```

8. bind方法与this

   与call/apply类似。

   **需要注意的一种情况：**

   ```js
   var o={
       prop:10,
       f:function(){
           function f1(){
               console.log(this);//Window {postMessage:ƒ, blur:ƒ, focus:ƒ, close:ƒ, frames:Window,...}
               console.log(this.prop); //undefined
           }
           f1();
       }
   }
   o.f();
   //函数f1虽然是对象o.f内部定义的，但是它仍然是一个普通的函数，this仍然指向window。
   ```

```js
// this
		console.log('------------------------this问题---------------');
		var number = 5;
		var obj1 = {
		    number: 3,
		    fn1: (function () {
		        var number;
		        this.number *= 2;
		        number = number * 2;
		        number = 3;
		        return function () {
		            var num = this.number;
		            this.number *= 2;
		            console.log(num);
		            number *= 3;
		            console.log(number);
		        }
		    })()
		}
		var fn1 = obj1.fn1;
		fn1.call(null);
		obj1.fn1();
		console.log(window.number);
		/*
			10
			9
			3
			27
			20
		*/
```

