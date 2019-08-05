---
title: vue深度监听
date: 2019-06-29 09:35:46
tags: Vue
categories: 前端
---

### vue深度监听

### 检测追踪变化的注意事项
> 当把一个普通js对象传入到vue实例作为data选项时，vue将会对此对象的所有属性进行遍历，并使用`Object.defineProperty`把这些属性全部转为`getter/setter`方法。

> 每个组件的实例都对应一个`watcher`实例，它会在组件渲染的过程中把“接触”过得数据属性记录为依赖。之后当依赖项的`setter`触发时，会通知`watcher`，从而使它相关联的组件进行更新渲染。

> 对于已经创建的实例，vue不允许动态添加根级别的响应式属性。但是，可以使用`Vue.set(object,propertyName,value)`方法向嵌套对象添加响应式属性（响应式属性指的是vue会在初始化实例时对属性执行`getter/setter`转化）。

> 如果需要为已有对象赋值多个新属性，比如使用`Object.assign()`或`_.extend()`。但是这样添加到对象上的新属性不会去触发更新。在这种情况下，需要用原对象与要混入进去的对象的属性一起创建一个新的对象。

```js
// 代替 Object.assign(this.someObject,{a: 1, b: 2})
this.someObject = Object.assign({},this.someObject,{a:1,b:2})
```
### 数据检测监听注意事项

> 由于js的限制，Vue不能检测以下数组的变动：

1. 当你利用索引直接设置一个数组项时，例如：`vm.items[indexOfItem] = newValue`
2. 当你修改数组的长度时，例如：`vm.items.length = newLength`
```js
var vm = new Vue({
  data: {
    items: ['a', 'b', 'c']
  }
})
vm.items[1] = 'x' // 不是响应性的
vm.items.length = 2 // 不是响应性的
```
解决方式：

```js
// 以下两种方式都可以实现直接赋值相同的效果，同时也将在响应式系统内触发更新状态

// 方式1 Vue.set
Vue.set(vm.items, indexOfItem, newValue)
// 或者全局使用`vm.$set`实例方法
vm.$set(vm.items, indexOfItem, newValue)

// 方式2  Array.prototype.splice
vm.items.splice(indexOfItem, 1, newValue)

```
为了解决第二类问题，你可以使用 splice：

```vm.items.splice(newLength)```

> 由于js的限制，Vue不能检测对象属性的添加或删除：需要使用`Vue.set(object, propertyName, value)`。如果想要为已有对象赋值多个属性，可以使用`Object.assign()` 或 `_.extend()`。

### 异步更新队列

> Vue 在更新 DOM 时是异步执行的。只要侦听到数据变化，Vue 将开启一个队列，并缓冲在同一事件循环中发生的所有数据变更。如果同一个 watcher 被多次触发，只会被推入到队列中一次。这种在缓冲时去除重复数据对于避免不必要的计算和 DOM 操作是非常重要的。Vue 在内部对异步队列尝试使用原生的 Promise.then、MutationObserver 和 setImmediate，如果执行环境不支持，则会采用 setTimeout(fn, 0) 代替。

> 例如，当你设置 vm.someData = 'new value'，该组件不会立即重新渲染。当刷新队列时，组件会在下一个事件循环“tick”中更新。多数情况我们不需要关心这个过程，但是如果你想基于更新后的 DOM 状态来做点什么，这就可能会有些棘手。虽然 Vue.js 通常鼓励开发人员使用“数据驱动”的方式思考，避免直接接触 DOM，但是有时我们必须要这么做。为了在数据变化之后等待 Vue 完成更新 DOM，可以在数据变化之后立即使用 Vue.nextTick(callback)。这样回调函数将在 DOM 更新完成后被调用

> 因为 $nextTick() 返回一个 Promise 对象，所以你可以使用新的 ES2016 async/await 语法完成相同的事情：

```js
methods: {
  updateMessage: async function () {
    this.message = '已更新'
    console.log(this.$el.textContent) // => '未更新'
    await this.$nextTick()
    console.log(this.$el.textContent) // => '已更新'
  }
}
```