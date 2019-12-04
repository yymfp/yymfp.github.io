---
title: CommonJS、AMD、CMD
date: 2018-10-20 11:16:56
tags: 模块开发规范
categories: 前端
---

### CommonJS、AMD、CMD

#### 在介绍这些之前，首先介绍下前端模块化的演变过程

### 前端模块化

1. 什么是模块化

   - 将一个复杂的程序按照一定的规则封装成几个块，并进行组合。
   - 块的内部数据与实现是私有的，外界没有操作改变的权限，只是暴露一些接口与外部其他模块通信。

2. 模块化的进化过程

   - 全局Function模式：将不同的功能封装成不同的全局函数

     > 问题：污染全局命名空间，容易引起命名冲突或数据不安全，而且模块成员之间看不出直接关系。

   - namespace模式：简单对象封装

     > 优点：减少全局变量的污染，解决命名冲突
     >
     > 问题：数据不是私有的（内部定义的数据可以被修改），不够安全。

   - IIFE模式：匿名函数自调用(闭包)

     > 作用：数据是私有的，外部只能通过暴露出去的方法进行操作
     >
     > 编码：将数据和行为封装到一个函数内部，通过给window添加属性来向外暴露接口
     >
     > 问题：如果当前模块依赖另一个模块时怎么办

     ```js
     (function(window){
       // 相关处理
       let name = 'bar',
           age = 20;
       // 私有方法
       function getName() {
         console.log(name);
       }
       function getAge() {
         console.log(age);
       }
       // 对外提供的入口方法
       function say() {
         getName();
         getAge();
       }
       // 对外暴露
       window.MyPeople = {say}
     })(window)
     ```

     

   - IIFE模式增强：引入依赖

     > 做法：将所依赖的库当做参数传入，这样就解决了依赖扩展问题。

3. 模块化的好处

   - 避免命名冲突，减少全局变量污染
   - 相关功能分离，降低了耦合性，可以做到按需加载
   - 更高的复用性
   - 更好维护

4. 引入多个`<script>`后出现的后果

   - 发起的请求过多
   - 多个外部js文件相互依赖关系不确定
   - 维护起来困难呢

5. 模块化规范

   > 模块化带来的好处是非常明显的，但是会存在第四点所说的那些问题，为了解决此类问题，所以就有了模块化编写规范的诞生。
   >
   > **在服务器端，模块的加载是运行时同步加载的（服务器端，文件的加载都是存储在服务器本地，读取本地文件是非常快的，所以采用同步加载的方式，对性能方面影响不大）；在浏览器端，模块需要提前编译打包处理，属于异步加载模式，这时候采用同步模式加载就不太合适了。（由于浏览器属于异步加载模式，如果采用同步模式的话，会造成阻塞。）**

   - CommonJS

     - 所有代码运行在模块作用域，不会污染全局作用域
     - 属于同步加载
     - 模块可以多次加载，但是只会在第一次加载时运行一次，加载结果会被缓存，后续再去加载的话，直接读取的是缓存，如果想要去重新加载，必须清除缓存。
     - 模块加载的顺序是自上而下按照代码出现的顺序。
     - CommonJS模块的加载机制是，输入的是被输出的值得拷贝。也就是说，一旦输出一个值，模块内部的变化就影响不到这个值了。(这与ES6模块化有所差异)

   - AMD

     - 非同步加载，允许指定回调函数。
     - 所有代码运行在模块作用域，不会污染全局作用域

   - CMD

     - 模块加载是异步的，模块使用时才会加载执行。

   - ES6

     ES6与CommonJS模块差异：

     - CommonJS模块输出的是一个值的拷贝，ES6模块输出的是值得引用。
     - CommonJS模块是运行时加载，ES6模块是编译时输出接口。

##### CommonJS

浏览器不兼容CommonJS的根本原因，在于其缺少四个Node.js环境的变量

- module

- exports

- require

- global

  **如果提供以上四个变量，浏览器就可以加载CommonJS模块**

  Browserify是CommonJS格式转换的工具，语法：

  > ```javascript
  > // foo.js
  > module.exports = function(x) {
  >   console.log(x);
  > };
  > 
  > // main.js
  > var foo = require("./foo");
  > foo("Hi");
  > ```

  使用下面的命令，就能将main.js转为浏览器可用的格式。

   

  > ```bash
  > $ browserify main.js > compiled.js
  > ```

   

  Browserify到底做了什么？安装一下[browser-unpack](https://www.npmjs.com/package/browser-unpack)，就能看清楚了。

   

  > ```bash
  > $ npm install browser-unpack -g
  > ```

   

  然后，将前面生成的compile.js解包。

   

  > ```bash
  > $ browser-unpack < compiled.js
  > 
  > [
  >   {
  >     "id":1,
  >     "source":"module.exports = function(x) {\n  console.log(x);\n};",
  >     "deps":{}
  >   },
  >   {
  >     "id":2,
  >     "source":"var foo = require(\"./foo\");\nfoo(\"Hi\");",
  >     "deps":{"./foo":1},
  >     "entry":true
  >   }
  > ]
  > ```

   

  可以看到，browerify 将所有模块放入一个数组，`id` 属性是模块的编号，`source` 属性是模块的源码，`deps` 属性是模块的依赖。

   

  因为 `main.js` 里面加载了 `foo.js`，所以` deps` 属性就指定 `./foo` 对应1号模块。执行的时候，浏览器遇到 `require('./foo') `语句，就自动执行1号模块的 `source` 属性，并将执行后的` module.exports` 属性值输出。

   使用CommonJS的不足之处在于同步加载。

  ```js
  var math=require('math');
  math.add(2,3);
  ```

  第二行的`math.add`依赖于`math`文件，需要等到`require('math')`执行之后，才能继续执行。也就是说，如果加载的文件过大的话，就会出现页面停在那里。

  这在服务器端不会存在问题，因为所有的模块都是存在本地的，读取可以同步加载完成，等待时间就是读取本地文件的时间，而在浏览器端就不同了，由于模块都是存放在服务器端的，如果网速过慢，或者文件过大，都会导致加载文件时浏览器产生"假死"状态。

  *CommonJS主要是为了JS在后端开发定制的，并不适用于前端，AMD（异步模块定义）主要为前端JS的表现定制的一套规范。*

##### AMD

特点：它采用异步加载方式加载模块，模块的加载不会影响到它后边的语句的执行，所有依赖当前模块的语句，都定义在一个回掉函数中，等加载完成后，才会执行回掉函数的内容。

require语法：

```js
require([module],callback); //接受两个参数
```

*参数`[module]`：是一个数组作为第一个参数，里边的成员就是要加载的模块；参数`callback`：加载成功后的回掉函数。*

目前主要有两个javascript库实现AMD规范：`require.js`和`curl.js`。

##### define函数：

> 语法：
>
> ```js
> define(id?,dependencies,factory);
> ```
>
> **id:**第一个参数，id，是个字符串。它指的是定义中模块的名字，这个参数是可选的。如果没有提供该参数，模块的名字应该默认为模块加载器请求的指定脚本的名字。如果提供了该参数，模块名**必须**是“顶级”的和绝对的（不允许相对名字）。
>
> **依赖：**第二个参数，dependencies，是个定义中模块所依赖模块的数组。依赖模块必须根据模块的工厂方法优先级执行，并且执行的结果应该按照依赖数组中的位置顺序以参数的形式传入（定义中模块的）工厂方法中。
>
> **工厂方法：**第三个参数，factory，为模块初始化要执行的函数或对象。如果为函数，它应该只被执行一次。如果是对象，此对象应该为模块的输出值。如果工厂方法返回一个值（对象，函数，或任意强制类型转换为true的值），应该为设置为模块的输出值。
>
> - 模块名是由一个或多个单词以正斜杠为分隔符拼接成的字符串
>
> - 单词须为驼峰形式，或者"."，".."
>
> - 模块名不允许文件扩展名的形式，如".js"
>
> - 模块名可以为 "相对的" 或 "顶级的"。如果首字符为"."或".."则为"相对的"模块名
>
> - 顶级的模块名从根命名空间的概念模块解析
>
> - 相对的模块名从 "require" 书写和调用的模块解析
>
>   相对模块名解析示例：
>
>   - 如果模块 `"a/b/c"` 请求 `"../d"`, 则解析为`"a/d"`
>
>   - 如果模块 `"a/b/c"` 请求 `"./e"`, 则解析为`"a/b/e"`
>

##### CMD

> 参考：
>
> [seajs]: https://github.com/seajs/seajs/issues/242

在CMD规范中，一个模块就是一个文件。

```js
define(factory);
```

`define`接受`factory`参数，`factory`可以是一个函数，也可以是一个对象或字符串。

`factory`为对象、字符串时，表示模块的接口就是该对象、字符串，比如为一个json数据模块：

```js
define({"foo":"bar"});
```

也可以通过字符串定义模板模块：

```js
define('I am a template. My name is {{name}}.');
```

`factory` 为函数时，表示是模块的构造方法。执行该构造方法，可以得到模块向外提供的接口。`factory` 方法在执行时，默认会传入三个参数：`require`、`exports` 和 `module`：

```js
define(function(require, exports, module) {

  // 模块代码

});
```

### define `define(id?, deps?, factory)`

`define` 也可以接受两个以上参数。字符串 `id` 表示模块标识，数组 `deps` 是模块依赖。比如：

```js
define('hello', ['jquery'], function(require, exports, module) {

  // 模块代码

});
```

`id` 和 `deps` 参数可以省略。省略时，可以通过构建工具自动生成。

**注意**：带 `id` 和 `deps` 参数的 `define` 用法不属于 CMD 规范，而属于 [Modules/Transport](https://github.com/cmdjs/specification/blob/master/draft/transport.md) 规范。

##### AMD和CMD异同

1. 相同之处：都是倡导模块化开发理念，核心价值是让JavaScript的模块化开发变得简单自然。
2. 不同之处：
   - **定位有差异**。RequireJS 想成为浏览器端的模块加载器，同时也想成为 Rhino / Node 等环境的模块加载器。Sea.js 则专注于 Web 浏览器端，同时通过 Node 扩展的方式可以很方便跑在 Node 环境中。
   - **遵循的规范不同**。RequireJS 遵循 AMD（异步模块定义）规范，Sea.js 遵循 CMD （通用模块定义）规范。规范的不同，导致了两者 API 不同。Sea.js 更贴近 CommonJS Modules/1.1 和 Node Modules 规范。
   - **推广理念有差异**。RequireJS 在尝试让第三方类库修改自身来支持 RequireJS，目前只有少数社区采纳。Sea.js 不强推，采用自主封装的方式来“海纳百川”，目前已有较成熟的封装策略。
   - **对开发调试的支持有差异**。Sea.js 非常关注代码的开发调试，有 nocache、debug 等用于调试的插件。RequireJS 无这方面的明显支持。
   - **插件机制不同**。RequireJS 采取的是在源码中预留接口的形式，插件类型比较单一。Sea.js 采取的是通用事件机制，插件类型更丰富。

**最后：SeaJS对模块的态度是懒执行（用到时再请求）, 而RequireJS对模块的态度是预执行（使用前请求模块）**



##### **es6 中的export export default 和node 中的module.exports exports区别**

1. export default导出的成员，可以使用任意的变量来接收

   ```js
   // a.js
   let obj = {name: '张三'};
   export default obj;
   
   // b.js
   import objName from './a.js';
   
   console.log(objName.name); // 张三
   ```

2. export 导出的成员，名字必须严格一致，需要改变名字时，使用**as**来起别名，使用{}形式接受，属于按需导出，可以暴露出多个成员

   ```js
   // a.js
   export function getName() {};
   
   // b.js
   import {getName} from './a.js';
   ```

3. node中exports 相当于是module.exports向外暴露的一个别名

   ```js
   var exports = module.exports;
   ```

   module变量是一个对象，代表当前模块(node中一个文件就是一个模块)，而exports是module的一个属性，加载某个模块其实是加载的当前模块的module.exports属性。

   