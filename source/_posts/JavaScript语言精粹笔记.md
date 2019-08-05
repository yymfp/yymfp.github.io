---
title: JavaScript语言精粹笔记
date: 2019-06-01 11:49:07
tags: js
categories: 读书笔记
---

### JavaScript语言精粹

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

- **删除对象中的属性**

  `delete`运算符可以用来删除对象的属性。它将会移除对象中确定包含的属性，它不会触及原型链中的任何对象。删除对象的属性可能会让来自原型链中的属性浮现出来。
  
- **减少全局变量污染**

  js可以很随意的定义那些可保存所有应用资源的全局变量。不幸的是，全局变量削弱了程序的灵活性，所以应该避免。
  
  最小化使用全局变量的一个方法是在你的应用中只创建唯一一个全局变量：
  
```js
var MYAPP = {};
```
  该变量此时变成了你的应用的容器：

```js
MYAPP.stooge = {
    "name": "Tom",
    "age": 20
};
MYAPP.flight = {
    airline: "Oceanic",
    number: 88,
    departure: {
        time: "2019-03-20 12:55",
        city: "Sydney"
    }
}
```
只要把多个全局变量都整理在一个名称空间下，你将显著降低与其他应用程序、组件或类库之间产生糟糕的相互影响的可能性。程序也会变得更易读。

- **函数对象**
  
  在js中函数就是对象。对象是一个“名/值”对的集合，并且拥有一个连到原型对象的隐藏连接。对象字面量产生的对象连接到`Object.prototype`。函数对象连接到`Function.prototype`（该原型对象本身连接到`Object.prototype`）。每个函数在创建时附有两个附加的隐藏属性：函数的上下文和实现函数行为的代码。
  
  因为函数是对象，所以它们可以像任何其他的值一样被使用。函数可以存放在变量、对象和数组中，函数也可以被当做参数传递给其他函数，函数也可以再返回函数。而且因为函数是对象，所以函数可以拥有方法。

  *函数的与众不同之处在于它们可以被调用。*
  
- **函数调用**
  
  调用一个函数时，将暂定当前函数的执行，传递控制权和参数给新函数。除了声明时定义的形式参数，每个函数接收两个附加的参数：this和arguments。

  在js中，一共有四种调用模式（这些模式在如何初始化关键参数this上存在差异）：
  
 1.   方法调用模式
        
      -- 当一个函数被保存为对象的一个属性时，我们称它为一个方法。当一个方法被调用时，this被绑定到该对象。

```js
// 创建myObject。它有一个value属性和一个increment方法。
// increment方法接受一个可选的参数。如果参数不是数字，那么默认使用数字1

var myObject ={
  value: 0,
  increment: function (inc) {
      this.value += typeof inc === 'number' ? inc : 1;
  }
}
myObject.increment();
console.log(myObject.value);  // 1

myObject.increment(2);
console.log(muObject.value);  //3
```
方法可以使用this去访问对象，所以可以从对象中取值或修改该对象。

 2.   函数调用模式
  
      -- 当一个函数并非一个对象的属性时，那么它被当作一个函数来调用：

```js
var sum = add(3, 4);  // sum的值是7
```
当函数以此模式调用时，this被绑定到全局对象。

 3.   构造器调用模式

      -- 如果在一个函数前面带上new来调用，那么将创建一个隐藏连接到该函数的prototype成员的新对象，同时this将会被绑定到那个新对象上。

```js
// 创建一个名为Quo的构造器函数。它构造一个代用status属性的对象

var Quo = function (string) {
    this.status = string;
}

Quo.prototype.get_status = function() {
    return this.status;
}

var myQuo = new Quo("confused");
```
 4.   apply调用模式

      -- apply方法让我们构建一个参数数组并用其去调用函数。允许我们选择this的值。apply方法接收两个参数，第一个是将被绑定给this的值，第二个就是一个参数数组。


```js
var statusObject = {
    status: 'A-OK'
};

// statusObject并没有继承自Quo.prototype,但我们可以在statusObject上调
// 用get_status方法，尽管statusObject并没有名为get_status的方法。

var status = Quo.prototype.get_status.apply(statusObject);  // status 值为 'A-OK'
```
- **闭包**

  函数内部返回出去的对象或函数可以访问它被创建时所处的上下文环境。被称为闭包。
  
  
```js
var myObject = function () {
    var value = 0;
    
    return {
        increment: function (inc) {
            value += typeof inc === 'number' ? inc : 1;
        },
        getValue: function () {
            return value;
        }
    }
}();

// 我们没有把一个函数赋值给myObject，而是将函数的返回结果赋值给了它。注意最后一行（）。
// 该函数返回一个包含两个方法的对象，并且这些方法继续享有访问value变量的特权。



// 创建一个名为quo的构造函数
// 它构造出带有get_status方法和status私有属性的一个对象。

var quo = function (status) {
    return {
        get_status: function () {
            return status;
        }
    }
}

// 构造一个quo的实例

var myQuo = quo("amazed");
console.log(myQuo.get_status());


// 这个函数被设计称无须在前面加上new来使用，所以名字也没有首字母大写，
// 调用quo时，返回带有get_status方法的新对象。该对象的一个引用保存在myQuo中
// 。即使quo已经返回了，但get_status方法仍然享有访问quo对象的status属性的特权。
// 它访问的就是该参数的本身而不是参数的拷贝。

```
- 记忆
  
  函数可以用对象去记住先前操作的结果，从而能避免无谓的运算。这种优化被称为记忆。

  
```js
  // 不适用记忆，采用递归函数计算Fibonacci数列。
  // 一个Fibonacci数字是之前两个Fibonacci数字之和。
  // 最初是两个数字是0和1。
  var fibonacci = function (n) {
      return n < 2 ? n : fibonacci(n - 1) + fibonacci(n - 2);
  };
  for (var i = 0; i <= 10; i += 1) {
      console.log('//' + i + ':' + fibonacci(i));
  }
  
  
  // 0: 0
  // 1: 1
  // 2: 1
  // 3: 2
  // 4: 3
  // 5: 5
  // 6: 8
  // 7: 13
  // 8: 21
  // 9: 34
  // 10: 55
```
  虽然这样是可以工作的，但它做了很多无谓的工作。fibonacci函数被调用了453次。我们调用了11次，而它自身调用了442次去计算可能已经被刚计算过的值。如果我们让该函数具备记忆功能，就可以显著地减少它的运算量。


```js
  // 使用memo数组保存计算结果,采用闭包的形式
  
  var fibonacci = function () {
      var memo = [0 ,1];
      var fib = function (n) {
          var result = memo[n];
          if (typeof result !== 'number') {
              result = fib(n - 1) + fib(n - 2);
              memo[n] = result;
          }
          return result
      }
      return fib;
  }();
```

  这个函数返回同样的结果，但它只被调用了29次。我们调用了11次。它自身调用了18次去取的计算结果。

  我们可以编写一个函数来帮助我们构造带记忆功能的函数。memoizer函数将取的一个初始的memo数组和fundamental函数。


```js
  var memoizer = function (memo, fundamental) {
      var shell = function (n) {
          var result = memo[n];
          if(typeof result !== 'number') {
              result = fundamental(shell, n);
              memo[n] = result;
          }
          return result;
      };
      return shell;
  }
  
  // 使用memoizer来定义fibonacci函数
  
  var fibonacci = memoizer([0 ,1], function (shell, n){
      return shell(n - 1) + shell(n - 2);
  });
  
  //  通过设计能产生出其他函数的函数，可以极大减少我们必须要做的工作。
  //  产生一个可以记忆的阶乘函数，我们只需提供基本的阶乘公式即可：

  var factorial = memoizer([1, 1], function (shell, n){
      return n * shell(n - 1);
  })
```

- 全局变量

  js所有糟糕的特性之中最为糟糕的就是它对全局变量的依赖性。全局变量就是在所有作用域中都可见的变量。全局变量可以被程序的任何部分在任何时间改变，它们会使得程序的行为被极大地复杂化。在程序中使用全局变量降低了程序的可靠性。
  
  全局变量使得在同一个程序中运行独立的子程序变得更难，如果某些全局变量的名称碰巧和子程序中的变量名称相同，那么它们将会相互冲突并可能导致程序无法运行，而且通常难以调试。
  
  定义全局变量有三种方式：
  
```js
// 第一种脱离任何函数安排一个var语句：
    var foo = value;
    
// 第二种是直接添加一个属性到全局对象上。
// 全局对象是所有全局变量的容器。
// 在Web浏览器里，全局对象名为window

    window.foo = value;
    
// 第三种是直接使用未经声明的变量。这被称为隐式的全局变量

    foo = value;
```

- 自动插入分号

  js有一个机制，它试图通过自动插入分号来修正有缺损的程序。千万不要依靠它，它可能会掩盖更为严重的错误。
  
  如果一个return语句返回一个值，这个值表达式开始部分必须和return在同一行上。
  
  
```js
    return
    {
        status: true
    }
    /*
        上述代码看起来是要返回一个包含status成员元素的对象，不幸的是，自动插入分号让它变成了返回undefined。
        如果把{放在上一行的尾部而不是下一行的头部就可以避免该问题
    */
    
    return {
        status: true
    }
```

- typeof

  typeof运算符返回一个用于表示其运算数类型的字符串。
  
  
```js
 typeof 98.6  // number
 typeof null // 返回object而不是null
 
 // typeof不能辨别出null与对象，可以像下面这样做
 // 因为null值为假，而所有对象值为真
 
 // my_value === null;
 if(my_value && typeof my_value === 'object') {
     // my_value是一个对象或数组
 }
```
- parseInt

  parseInt是一个将字符串转换为整数的函数。它在遇到非数字时停止解析，所以parseInt("16")与parseInt("16 tons")产生相同的结果。
  
  如果该字符串第一个字符是0，那么该字符串将被基于八进制而不是十进制来求值。在八进制中，8和9不是数字，所依parseInt("08")和parseInt("09")产生0作为结果。这个错误导致了程序解析日期和时间时出现问题。幸运的是，parseInt可以接受一个基数作为参数，parseInt("08",10)结果为8。使用parseInt总是提供这个基数参数是有必要的。
  
- '+'

  '+'运算符可以用于加法运算或字符串连接。如果其中一个运算数是一个空字符串，它会把另一个运算数转换成字符串并返回。如果两个运算数都是数字，它返回两者之和。如果你打算用+去做加法运算，请确保两个运算数都是整数。
  
- NaN

  NaN是IEEE754中定义的一个特殊的数量值，它表示不是一个数字。
  
  ```js
  typeof NaN === 'number'  // true
  
  // 该值可能会在试图将非数字形式的字符串转换为数字时产生。
  
  + '0'  // 0
  + 'aksk' // NaN
  
  // 需要注意的是，如果你有一个公式链产生出NaN的结果，那么至少其中一个输入项是NaN，或者在某个地方产生了NaN。
  
  // NaN不等同与它自己
  
  NaN === NaN   // false
  NaN !== NaN   // true
  
  // js提供了isNaN函数检测是否是NaN
  
  isNaN(NaN);   // true
  isNaN(0);   // false
  isNaN('asnsnsn');   // ture
  isNaN('0');  // false
  ```
  
  判断一个值是否可用做数字的最佳方法是使用isFinite函数，因为它会筛除掉NaN和Infinity。不幸的是，isFinite会试图把它的运算数转换为一个数字，所以，如果值事实上不是一个数字，它就不是一个好的测试。可以自己定义isNumber函数：
  
  ```js
    function isNumber(value) {
        return typeof value === 'number' && isFinite(value);
    }
  ```
  
- 伪数组

  js没有真正的数组。
  
  typeof运算符不能辨别数组和对象。要判断一个值是否为数组，必须要检查它的constructor属性：
  
  
```js
    if(my_value && typeof my_value === 'object' && my_value.constructor === Array) {
        // my_value是一个数组
    }
```
上面的检测对于在不同的帧或窗口创建的数组将会给出false。当数组有可能哎其他的帧中被创建时，下面的检测更为可靠：


```js
    if(my_value && typeof my_value === 'object' && typeof my_value.length === 'number' && !(my_value.propertyIsEnumerable('length'))) {
        // my_value确实是一个数组
    }
```

-  ==

  js有两组相等运算符：=== 和 !==，以及 == 和 !=。 === 和 !==这一组运算符会按照你期望的方式工作。如果两个运算数类型一致且拥有相同的值，那么 === 返回 true，而 !==返回false。而 == 和 !=只有在两个运算数类型一致时才会做出正确的判断，如果两个运算数是不同的类型时，它们试图去强制转换类型。
  
  
```js
 '' == '0'   // false
 0 == ''     // true
 0 == '0'    // true
 
 false == 'false'  // false
 false == '0'  // true
 
 false == undefined  // false
 false == null    // false
 null == undefined   // true

```
== 运算符对传递性的缺乏值得我们警惕。建议永远不要用== 和 !=。始终使用 === 和 !==。

> 传递性是一种编程约定。可以这么去理解：对于任意的引用值x、y和z，如果x == y和y == z为true，那么x == z 为true。而js中的==运算符在某些特例上违背了传递性。

****

**避免使用with语句，with语句严重影响了js处理器的速度，因为它阻止了变量名的词法作用域绑定。**

****

**避免使用eval。使用它会使得性能显著降低，因为它须运行编译器。**
* Function构造器是eval的另一种形式，所以它同样也应该被避免使用。
* 浏览器提供的setTimeout和setInterval函数，它们能接受字符串参数或函数参数。当传递的是字符串参数时，setTimeout和setInterval会像eval那样去处理。字符串参数形式也应该被避免使用。

****

**continue语句**

continue语句跳到循环的顶部。通过移除continue语句后，性能会得到改善。

****

**switch贯穿**

使用switch语句时，每一个条件都是需要添加break，防止上一个case条件向下贯穿到另一个case条件。

****

**function语句对比函数表达式**

js中既有function语句，同时也有函数表达式。这是令人困惑的，因为它们看起来就是相同的。一个function语句就是其值为一个函数法人var语句的速记形式。


```js
    // 下面语句：
    function foo () {}
    
    //意思相当于：
    var foo = function foo() {};
```

第二种形式能明确表示foo是一个包含一个函数值的变量。function语句在解析时会发生被提升的情况，这意味着不管function被放置在哪里，它会被移动到被定义时所在作用域的顶层。禁止在if语句中声明function语句。

一个语句不能以一个函数表达式开头，因为官方的语法假定以单词function开头的语句是一个function语句。解决方法就是把函数表达式括在一个圆括号之中。


```js
    (function () {
        var hidden_variable;
        
        // 这个函数可能对环境有一些影响，但不会引入新的全局变量
    })
```

****

**在使用new运算符创建新对象时，千万别忘了new，否则会造成this被绑定到全局对象，而不是新创建的对象。**