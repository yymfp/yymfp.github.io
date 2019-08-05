---
title: js继承
date: 2018-10-05 15:46:12
tags: js
categories: 前端
---

### js继承

```javascript
funtion Animal(){
    this.type='animal';
}
function Dog(name,food){
    this.name=name;
    this.food=food;
}
```

如何让Dog继承Animal呢？

1. **对构造函数进行绑定（通过使用function的`call、apply方法，将父对象的构造函数绑定在子对象上）**

   ```javascript
   function Dog(name,food){
       Animal.call(this,arguments); //this的指向属于dog
       this.name=name;
       this.food=food;
   }
   let dog=new Dog('小黄','骨头');
   console.log(dog.type); //animal
   ```

   以上代码相当于：

   ```javascript
   function Dog(name,food){
       this.type='animal';	//this的指向属于dog
       this.name=name;
       this.food=food;
   }
   let dog=new Dog('小黄','骨头');
   console.log(dog.type); //animal
   ```


​     2.**利用prototype**

实现方式：

```javascript
Dog.prototype=new Animal();  //通过修改Dog的prototype对象，让其指向Animal的实例。
Dog.prototype.constructor=Dog; 
let dog=new Dog('小黄','骨头'); //对象dog的__proto__指向Dog的prototype(也就是Animal)
console.log(dog.type); //animal
```

> 上述代码中,第一行将Dog原来的`prototype`整体替换成了Animal,由于任何一个`prototype`对象都有一个`constructor`属性,而这个属性指向它的构造函数.也就是说:
>
> ```javascript
> console.log(Dog.prototype.constructor==Dog); //true
> ```
>
> 而第一行代码将原本指向Dog的`constructor`属性改成了指向Animal:
>
> ```javascript
> Dog.prototype=new Animal();
> console.log(Dog.prototype.constructor==Animal); //true
> ```
>
> 这样就会造成一种现象:dog明明是被构造函数Dog生成的,而`constructor`却指向了构造函数Animal,这显然不是我们想要的,所以需要对`constructor`的指向重新赋值:
>
> ```javascript
> Dog.prototype.constructor=Dog;
> ```
>
>

##### 3.利用空对象作为中介

方法二中继承时，需要创建Animal的实例，比较浪费内存。

```js
let O = function(){};
O.prototype=Animal.prototype;
Dog.prototype=new O();
Dog.prototype.constructor=Dog;
```

*O是一个空对象，几乎不占用内存。而且修改Dog.prototype也不会影响到Animal的prototype对象。*

将其封装成一个函数：

```js
function extend(Child,Parent){
    let O=function(){};
    O.prototype=Parent.prototype;
    Child.prototype=new O();
    Child.prototype.constructor=Child;
    Child.uber=Parent.prototype;   //预留的访问父对象的接口
}
```

