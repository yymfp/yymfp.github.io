---
title: ES6
date: 2019-05-01 12:57:05
tags: js
categories: 前端
---

### ES6新增语法

1. 新增关键字

   - let：作用与var类似，用于声明变量。

     特点：

     1. 在块级作用域内有效。

     2. 不能重复声明。

     3. 不会预处理，不存在变量提升。

        ```js
        let btns = document.getElementsByTagName('button');
        for(var i = 0; i<btns.length; i++) {
    var btn = btns[i];
            btn.onclick = function() { //属于回掉函数，在主线程执行结束后，点击触发时，此时i为btns.length-1
                console.log(i); //所有的打印结果都为btns.length-1
            }
        }
        //可以通过立即执行函数来解决（闭包的原理）
        let btns = document.getElementsByTagName('button');
        for(var i = 0; i<btns.length; i++) {
            var btn = btns[i];
            (function (i){
                btn.onclick = function() {
                    console.log(i); //打印出来为数组的下标对应
                }
            })(i)
        }
        //let有自己的块级作用域，可以通过let来控制循环
        let btns = document.getElementsByTagName('button');
        for(let i = 0; i<btns.length; i++) {
            var btn = btns[i];
            btn.onclick = function() {
                console.log(i);
            }
        }
        ```
        
     
     > let相比于var：
     >
     > 1. let声明的变量拥有块级作用域，let声明仍然保留了提升的特性，但不会盲目提升。
     > 2. let声明的全局变量不是全局对象上的属性。不可以通过**window.变量名**的方式访问。
     > 3. 形如`for (let x...)`的循环在每次迭代时都为x创建新的绑定。
     > 4. let声明的变量直到控制流到达该变量被定义的代码行时才会被装载，所以在到达之前使用该变量会触发语法错误。
     
   - const：作用是定义一个常量。
   
     特点：
   
     1. 不能修改
     2. 其他的特点同let
   
     主要应用于保存不变的数据。
   
2. 变量的解构赋值

   - 从对象或数组中提取数据，并赋值给变量（多个）。

   - 对象的解构赋值。

     ```js
     let {n,a} = {n:'123',a:'456'};
     console.log(n); //'123'
     console.log(a); //'456'
     ```

   - 数组的解构赋值。

     ```js
     let [a,b] = ['aaa','bbb'];
     console.log(a); //'aaa'
     console.log(b); //'bbb'
     ```

   - 用途：给多个形参赋值。

     ```js
     let obj = {username:'zhangsan',age:20};
     function foo({username,age}) {
         console.log(username,age);
     }
     foo(obj);
     ```

3. 模板字符串

   - 简化字符串的拼接

   - 模板字符串必须用``包含

   - 变量的部分使用${xxx}定义

     ```js
     let name = '张三';
     let str = `http://www.getUser.com?username=${name}`;
     ```

4. 简化的对象写法

   - 省略同名的属性值

   - 省略方法的function

     ```js
     let x = 1;
     let y = 2;
     let obj = {
         x,
         y,
         getX () {
             console.log(this.x)
         }
     }
     ```

5. 箭头函数

   - 作用：定义匿名函数

   - 基本语法：

     ```js
     //没有参数：
     () => console.log('xxx')
     //一个参数：
     i => i+2
     //多个参数：
     (i,j) => i+j
     //函数体不用大括号：默认返回结果
     //函数体若有多条语句，需要使用{}包裹起来，若需要返回内容，则需要手动return
     //箭头函数多用来定义回调函数
     ```

   - 特点：

     1. 简洁。
     2. 箭头函数没有自己的this，箭头函数内部使用的this不是调用的时候决定的，而是在定义的时候。
     3. 如何分辨箭头函数的this：箭头函数的this看外层是否有函数，如果有，外层函数的this就是箭头函数内部的this，如果没有，则this指向window。

   > 箭头函数与传统函数的区别：
   >
   > 1. 没有this、super、arguments和new.target绑定，这些值由最近一层非箭头函数决定。
   > 2. 不能通过new关键字调用，所以不能用作构造函数，否则程序会抛出错误。
   > 3. 没有原型。由于不可以通过new关键字调用箭头函数，因而没有构建原型的需求，所以箭头函数不存在prototype这个属性。
   > 4. 不可以改变this的绑定，函数内部的this值不可以被改变，在函数的生命周期内始终保持一致。
   > 5. 不支持arguments对象，所以你必须通过命名参数和不定参数这两种形式访问函数的参数。
   > 6. 不支持重复的命名参数，无论在严格还是非严格模式下，都不支持，而在传统的函数规定中只有在严格模式下才不能有重复命名参数。

6. 三点运算符

   - 用途：可变参数用来取代arguments，但比arguments灵活，只能时最后部分形参参数。

     ```js
     function fun(a, ...values) {
         console.log(arguments);
         //arguments是伪数组，不具备数组的一般方法，例如forEach方法等。
         //arguments.forEach(function(item, index) { //报错
          //   console.log(item,index);
         //})
         values.forEach((item, index) => {
             console.log(item, index);
         })
     }
     fun(2,3,4,5,6,7);
     ```

   - 扩展运算符

     ```js
     let arr1 = [1,2,3];
     let arr2 = [...arr1,4,5,6];
     console.log(arr2); //[1,2,3,4,5,6]
     //或者
     arr2.push(...arr1);
     ```

7. 形参默认值

   - 当不传入参数时，默认使用形式参数的默认值

     ```js
     function Point(x = 1, y = 2) {
         this.x = x;
         this.y = y;
     }
     ```

8. Promise对象

   - 作用：代表了未来某个将要发生的事件（通常是一个异步操作）

   - 有了Promise对象，可以将异步操作以同步的流程表达出来，避免了层层嵌套的回调函数（俗称'回调地狱'）

   - ES6的Promise是一个构造函数，用来生成promise实例

   - 使用Promise基本步骤：

     1. 创建promise对象

        ```js
        let promise = new Promise((resolve, reject) => {
            //初始化promise状态为pending
            //执行异步操作
            if(异步操作成功) {
            	resolve(value); //修改promise的状态为fullfilled
            }else {
            	reject(errMsg); //修改promise的状态为rejected
            }
        })
        ```

     2. 调用promise的then()

        ```js
        promise.then((resolve) => {
          //成功时处理  
        },(reject) => {
            //失败时处理
        })
        ```

     3. promise对象的三个状态

        - pending：初始化状态
        - fullfilled：成功状态
        - rejected：失败状态

     4. 应用：

        - 使用promise实现超时处理
        - 使用promise封装处理ajax请求
     
   - promise实现原理

     
   
     ```js
     // 初始化状态值
     const PENDING = 'pending';
     const FULFILLED = 'fulfilled';
     const REJECTED = 'rejected';
     
     // Promise
     function _Promise(handle) {
     	
     	let self = this;
     	self.status = PENDING;
     	self.onFulfilled = []; // 执行成功时的回调
     	self.onRejected = [];  // 执行失败时的回调
     
     	// 定义resolve方法
     	function resolve(value) {
     		if(self.status === PENDING) {
     			self.status = FULFILLED;
     			self.value = value;
     			self.onFulfilled.forEach(fn => fn());
     		}
     	}
     
     	// 定义reject方法
     	function reject(reason) {
     		if(self.status === PENDING) {
     			self.status = REJECTED;
     			self.reason = reason;
     			self.onRejected.forEach(fn => fn());
     		}
     	}
     
     	try {
     		handle(resolve,reject);
     	}catch(err) {
     		reject(err);
     	}
     }
     
     // Promise.then
     _Promise.prototype.then = function(onFulfilled, onRejected) {
     
     	// 判断回调函数类型
     	onFulfilled = typeof onFulfilled === 'function' ? onFulfilled : value => value;
     	onRejected = typeof onRejected === 'function' ? onRejected : reason => { throw reason };
     
     	let self = this; // this代表Promise实例本身
     
     	// 定义需要返回出去的Promise
     	let Promise2 = new _Promise((resolve, reject) => {
     		
     		// 如果状态为成功
     		if(self.status === FULFILLED) {
     
     			// 这里使用setTimeout不是特别清楚，自己认为可能是为了实现同步逻辑
     			setTimeout(() => {
     				try {
     					let x = onFulfilled(self.value);
     					resolvePromise(Promise2, x, resolve, reject);
     				}catch(err) {
     					reject(err);
     				}
     			})
     		}else if(self.status === REJECTED) { // 如果状态为失败
     			setTimeout(() => {
     				try {
     					let x = onRejected(self.reason);
     					resolvePromise(Promise2, x, resolve, reject);
     				}catch(err) {
     					reject(err);
     				}
     			})
     		}else if(self.status === PENDING) { // 如果状态为进行中
     
     			// 成功回调队列添加
     			self.onFulfilled.push(() => {
     				setTimeout(() => {
     					try {
     						let x = onFulfilled(self.value);
     						resolvePromise(Promise2, x, resolve, reject);
     					}catch(err) {
     						reject(err);
     					}
     				})
     			})
     
     			// 失败回调队列添加
     			self.onRejected.push(() => {
     				setTimeout(() => {
     					try {
     						let x = onRejected(self.reason);
     						resolvePromise(Promise2, x, resolve, reject);
     					}catch(err) {
     						reject(err);
     					}
     				})
     			})
     		}
     	});
     	return Promise2;
     }
     
     function resolvePromise(Promise2, x, resolve, reject) {
     	let self = this;
     
     	// 判断Promise2 与 x是否一致
     	if(Promise2 === x) {
     		reject(new TypeError("Promise2与x一致，拒绝执行promise"))
     	}
     
     	if(x && typeof x === 'object' || typeof x === 'function') { // 判断x是否为对象或者函数
     		let used;  // 只允许调用一次
     		try {
     			let then = x.then;  // 获取x的then方法
     
     			// 判断then是否是函数，如果是则认为x是一个promise对象，如果不是则x为普通对象
     			if(typeof then === 'function') {
     				then.call(x, y => {
     					// y 代表x的resolve所传入的参数
     
     					if(used) {
     						return;
     					}
     					used = true;
     					resolvePromise(Promise2, y, resolve, reject);  //递归调用
     				}, err => {
     					if(used) {
     						return;
     					}
     					used = true;
     					reject(err);
     				})
     			}else { // x为普通对象
     				if(used) {
     					return;
     				}
     				used = true;
     				resolve(x);
     			}
     		}catch(err) {
     			if(used) {
     				return;
     			}
     			used = true;
     			reject(err);
     		}
     	}else {
     		resolve(x)
     	}
     
     }
     module.exports = _Promise;
     // 添加测试代码
     
     _Promise.defer = _Promise.deferred = function () {
         let dfd = {};
         dfd.promise = new _Promise((resolve, reject) => {
             dfd.resolve = resolve;
             dfd.reject = reject;
         });
         return dfd;
     }
     ```

   
  
   
- Promise其他方法
  
  - Promise.resolve
  
     >  Promise.resolve(value)返回一个以给定值解析后的Promise 对象.
  
  1. 如果 value 是个 thenable 对象，返回的promise会“跟随”这个thenable的对象，采用它的最终状态
     2. 如果传入的value本身就是promise对象，那么Promise.resolve将不做任何修改、原封不动地返回这个promise对象。
     3. 其他情况，直接返回以该值为成功状态的promise对象。
  
     ```js
     Promise.resolve = function (param) {
             if (param instanceof Promise) {
             return param;
         }
         return new Promise((resolve, reject) => {
             if (param && param.then && typeof param.then === 'function') {
                 setTimeout(() => {
                     param.then(resolve, reject);
                 });
             } else {
                 resolve(param);
             }
         });
     }
  
     ```
  - Promise.reject
  
     > Promise.reject方法和Promise.resolve不同，Promise.reject()方法的参数，会原封不动地作为reject的理由，变成后续方法的参数。
  
     ```js
     Promise.reject = function (reason) {
         return new Promise((resolve, reject) => {
             reject(reason);
         });
  }
     ```
  - Promise.catch
  
     > Promise.prototype.catch 用于指定出错时的回调，是特殊的then方法，catch之后，可以继续 .then
  
     ```js
     Promise.prototype.catch = function (onRejected) {
         return this.then(null, onRejected);
  }
     ```
  - Promise.finally
  
     > 不管成功还是失败，都会走到finally中,并且finally之后，还可以继续then。并且会将值原封不动的传递给后面的then.
  
     ```js
     Promise.prototype.finally = function (callback) {
         return this.then((value) => {
             return Promise.resolve(callback()).then(() => {
                 return value;
             });
         }, (err) => {
             return Promise.resolve(callback()).then(() => {
                 throw err;
             });
         });
  }
     ```
  - Promise.all
  
     > Promise.all(promises) 返回一个promise对象
  
     1. 如果传入的参数是一个空的可迭代对象，那么此promise对象回调完成(resolve),只有此情况，是同步执行的，其它都是异步返回的。
     2. 如果传入的参数不包含任何promise，则返回一个异步完成.
     3. promises 中所有的promise都promise都“完成”时或参数中不包含 promise 时回调完成。
     4. 如果参数中有一个promise失败，那么Promise.all返回的promise对象失败
     5. 在任何情况下，Promise.all 返回的 promise 的完成状态的结果都是一个数组


```js

 Promise.all = function (promises) {
     return new Promise((resolve, reject) => {
         let index = 0;
         let result = [];
         if (promises.length === 0) {
             resolve(result);
         } else {
             function processValue(i, data) {
                 result[i] = data;
                 if (++index === promises.length) {
                     resolve(result);
                 }
             }
             for (let i = 0; i < promises.length; i++) {
                   //promises[i] 可能是普通值
                   Promise.resolve(promises[i]).then((data) => {
                     processValue(i, data);
                 }, (err) => {
                     reject(err);
                     return;
                 });
             }
         }
     });
 }

```

- Promise.race

1. Promise.race函数返回一个 Promise，它将与第一个传递的 promise 相同的完成方式被完成。它可以是完成（ resolves），也可以是失败（rejects），这要取决于第一个完成的方式是两个中的哪个。
2. 如果传的参数数组是空，则返回的 promise 将永远等待。
3. 如果迭代包含一个或多个非承诺值和/或已解决/拒绝的承诺，则 Promise.race 将解析为迭代中找到的第一个值。



参考 

 https://www.jianshu.com/p/43de678e918a

 http://www.ituring.com.cn/article/66566

 https://juejin.im/post/5c88e427f265da2d8d6a1c84#comment

9. Symbol

   - 前言：ES5中对象的属性名都是字符串，容易造成重名，污染环境

   - Symbol属于ES6新添加的原始数据类型。已有的原始数据类型（String，Number，bollean,null,undefined,Object）

   - 特点：

     1. Symbol属性对应的值是唯一的，解决命名冲突问题
     2. Symbol值不能与其他数据进行计算，包括同字符串拼串
     3. for in，for of遍历时不会遍历symbol属性

   - 使用：

     1. 调用Symbol函数得到Symbol值

        ```js
        let symbol = Symbol();
        let obj = {};
        obj[symbol] = 'hello'
        ```

     2. 传参标识

        ```js
        let symbol1 = Symbol('one');
        let symbol2 = Symbol('two');
        console.log(symbol1); //Symbol('one')
        console.log(symbol2); //Symbol('two')
        ```

     3. 内置Symbol值

        - 除了定义自己使用的Symbol值以外，ES6还提供了11个内置的Symbol值，指向语言内部使用的方法
        - Symbol.iterator
          * 对象的Symbol.iterator属性，指向该对象的默认遍历器方法

10. iterator

    - 概念：iterator是一种接口机制，为各种不同的数据结构提供统一的访问机制

    - 作用：

      1. 为各种数据结构，提供统一的，简便的访问接口
      2. 使得数据结构的成员能够按某种次序排列
      3. ES6创造了一种新的遍历方法for  of循环，Iterator接口主要供for of消费

    - 工作原理：

      1. 创建一个指针对象（遍历器对象），指向数据结构的起始位置。
      2. 第一次调用next方法，指针自动指向数据结构的第一个成员。
      3. 接下来不断调用next方法，指针会一直往后移动，直到指向最后一个成员。
      4. 每次调用next方法返回的是一个包含value和done的对象，{value: 当前成员的值，done：布尔值}
         - value代表当前成员的值，done对应的布尔值表示当前数据的结构是否遍历结束
         - 当遍历结束的时候返回的value值是undefined，done的值是false

    - 原生具备Iterator接口的数据（可用for of循环）

      扩展理解：

      1. 当数据结构上部署了Symbol.iterator接口，该数据就是可以用for of遍历
      2. 当使用for of去遍历目标数据的时候，该数据会自动去找Symbol.iterator属性
      3. 具有Iterator接口的原生数据类型：
         - Array
         - arguments
         - set容器
         - map容器
         - String

    ```js
    //模拟指针对象（遍历器对象）
    function myIterator(arr) {
        let nextIndex = 0;
        return {
            next:function () {
                return nextIndex < arr.length?{value: arr[nextIndex++], done: false}:{value:undefined,done:true}
            }
        }
    }
    //三点运算符，解构赋值，默认调用iterator接口
    ```

    