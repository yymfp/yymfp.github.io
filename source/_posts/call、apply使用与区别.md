---
title: call、apply使用与区别
date: 2018-10-05 16:55:01
tags: js
categories: 前端
---

### call、apply使用与区别

javaScript中的每个Function对象都有一个apply()方法和call()方法，两者作用一样，唯一的不同点就是参数不同，语法：

**call**：方法调用一个函数，其具有一个指定的this值和分别地提供的参数（参数列表）。

```javascript
function.call(thisObject,arg1,arg2,arg3,...);
```

举例：

```javascript
//改变this指向
window.a='哈哈';
document.a='嘿嘿';
var s={a:'嘻嘻'};
function changea(){
    console.log(this.a);
}
changea.call(); //'哈哈'
changea.call(window); //'哈哈'
changea.call(document); //'嘿嘿'
changea.call(s); //'嘻嘻'
changea.call(this); //'哈哈'

//调用匿名函数
let Persons=[
    {
        name:'张三',
        age:20
    },
    {
        name:'李四',
        age:30
    }
]
for(let i=0;i<Persons.length;i++){
    (function(i){
        this.say=function(){
            console.log(i+'我叫'+this.name+'今年'+this.age+'岁');
        }
    }).call(Persons[i],i)
}
Persons[0].say(); //0我叫张三今年20岁
Persons[1].say(); //1我叫李四今年30岁
```

**apply:**方法调用一个具有给定this值的函数，以及作为一个数组（或者类似数组对象）提供的参数。

```javascript
function.apply(thisObj,[argsArray]);
```

举例：

```javascript
//改变this指向
window.a='哈哈';
document.a='嘿嘿';
var s={a:'嘻嘻'};
function changea(){
    console.log(this.a);
}
changea.apply(); //'哈哈'
changea.apply(window); //'哈哈'
changea.apply(document); //'嘿嘿'
changea.apply(s); //'嘻嘻'
changea.apply(this); //'哈哈'
```

*使用apply将数组添加到另一个数组*:

> 我们可以使用`push`将元素追加到数组中。并且，因为push接受可变数量的参数，我们也可以一次推送多个元素。但是，如果我们传递一个数组来推送，它实际上会将该数组作为单个元素添加，而不是单独添加元素，因此我们最终得到一个数组内的数组。如果那不是我们想要的怎么办？在这种情况下，`concat`确实具有我们想要的行为，但它实际上并不附加到现有数组，而是创建并返回一个新数组。 但是我们想要附加到我们现有的阵列......那么现在呢？ 写一个循环？当然不是吗？

```javascript
let arr1=[1,2];
let arr2=[3,4,5];
//如果使用push
arr1.push(arr2);
console.log(arr1); //[1,2,[3,4,5]]
//可以看到，得到的并不是我们想要的一维的数组
arr1.push.apply(arr1,arr2);
console.log(arr1); //[1,2,3,4,5]
```

**两者传递参数差异：**

```javascript
function change(name,age){
    console.log(name,age);
}
change.call(this,'张三',20); //张三 20
change.apply(this,['张三',20]) //张三 20
```

### call、apply以及bind异同点

- 相同点
    * 都可以用来改变this指向问题。
- 不同点
    * call和apply都是调用即执行，而bind不会立即执行。
    * call和apply传递的参数不一样，call传递参数是一个参数列表，而apply第二个参数需要是一个数组。
****
**实现原理**

- call

```js
    // call实现原理
	Function.prototype._call = function (context) {
		
		// context是否存在
		if(!context) {
			context = window !== 'undefined' ? window : global;
		}

		context.fn = this; // this代表函数实例本身，将函数实例添加到context对象的属性中
		let rest = [...arguments].splice(1);  // 获取到去除context外的所有参数
		let result = context.fn(...rest);  // 隐式绑定this，此时调用fn函数内部this指向context
		delete context.fn;
		return result
	}
	
	let ooo = {
		name: '张三'
	}
	function getName() {
		console.log(this.name,arguments);
	}
	console.log(getName._call(ooo,1,2,3)); // 张三 Arguments(3) [1, 2, 3, callee: ƒ, Symbol(Symbol.iterator): ƒ]
```
- apply


```js
    // apply实现原理
	Function.prototype._apply = function (context, arr) {

		// context是否存在
		if(!context) {
			context = window !== 'undefined' ? window : global;
		}

		context.fn = this;  // this代表函数实例本身
		let result;
		if(arr === undefined || arr === null) {
			result = context.fn(arr);
		}else if(typeof arr === 'object') {
			result = context.fn(...arr);
		}
		delete context.fn;
		return result
	}
	let ooo = {
		name: '张三'
	}
	function getName() {
		console.log(this.name,arguments);
	}
	console.log(getName._apply(ooo,[1,2])); // 张三 Arguments(2) [1, 2, callee: ƒ, Symbol(Symbol.iterator): ƒ]
```
- bind


```js
    // bind实现原理
	Function.prototype._bind = function (context) {
		if(typeof this !== 'function') {
			throw new TypeError("not a function");
		}
		let self = this;

		let rest = [...arguments].splice(1);  // 获取bind所有参数
		function Fn(){};
		Fn.prototype = this.prototype;
		let bound = function() {
			let args = [...rest,...arguments]; // 获取到bind传入的参数以及执行函数传入的参数
			context = this instanceof Fn ? this : context || this;  // 谁调用bound函数，this就指向谁
			return self.apply(context,args);
		}

		// 原型链
		bound.prototype = new Fn();
		return bound
	}
	
	let ooo = {
			name: '张三'
		}
		function getName() {
			console.log(this.name,arguments);
		}
		
		console.log(getName._bind(ooo,1,2)(3)); // 张三 Arguments(3) [1, 2, 3, callee: ƒ, Symbol(Symbol.iterator): ƒ]
```