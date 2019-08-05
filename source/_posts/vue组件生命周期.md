---
title: vue组件生命周期
date: 2018-10-21 16:30:32
tags: Vue
categories: 前端
---

### vue组件生命周期

参考自Vue官方：https://cn.vuejs.org/v2/api/

生命周期的概念：每个组件的实例，从创建、到运行、直到销毁，在这个过程中，会发生一系列事件，这些事件就叫做组件的生命周期函数。

**需要注意的是：**

> 所有的生命周期钩子自动绑定`this`上下文到实例中，因此你可以访问数据，对属性和方法进行运算。这意味着你不能使用箭头函数来定义一个生命周期方法。这是因为箭头函数绑定了父上下文，因此`this`与你期待的Vue实例不同。

![参考：https://cn.vuejs.org/v2/guide/instance.html](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/31/da4542b8404aacff8083b804fa48db76.png)

1. beforeCreate：这是第一个生命周期函数，此时组件的data和methods以及页面DOM结构，都还没有初始化，所以此阶段，什么都做不了。

2. create：此时，组件的data和methods已经可用。在这一步，实例已经完成以下的配置：数据观测（data observer），属性和方法的运算，watch/event事件回调。然而，挂载阶段还没开始，`$el`属性目前不可见。**在这个生命周期函数中，我们经常会发起Ajax请求。**

3. beforeMount：在挂载开始之前被调用：相关的`render`函数首次被调用。

4. mounted：`el`被新创建的`vm.$el`替换，并挂载到实例上去之后调用该钩子。如果root实例挂载了一个文档内元素，当`mounted`被调用时`vm.$el`也在文档内。**需要注意的是：`mounted`不会承诺所有的子组件也都一起被加载，如果你希望等到整个视图都渲染完毕，可以用`vm.$nextTick`替换掉`mounted`**，如果页面用到了第三方UI插件，而且这个插件还需要被初始化，那么必需在mounted中来初始化插件。

   ```js
   mounted:function(){
       this.$nextTick(function(){
           //等到整个视图加载完成后的操作
       })
   }
   ```

5. beforeUpdate：数据更新时的调用，在此阶段，数据是最新的，但是页面是旧的。

6. updated：由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。

   当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用[计算属性](https://cn.vuejs.org/v2/api/#computed)或 [watcher](https://cn.vuejs.org/v2/api/#watch) 取而代之。

   **注意 `updated` 不会承诺所有的子组件也都一起被重绘。如果你希望等到整个视图都重绘完毕，可以用 [vm.$nextTick](https://cn.vuejs.org/v2/api/#vm-nextTick) 替换掉 `updated`**：

   ```js
   updated: function () {
     this.$nextTick(function () {
       // Code that will run only after the
       // entire view has been re-rendered
     })
   }
   ```

7. activated：`keep-alive`组件激活时调用。
8. deactivated：`keep-alive`组件停用时调用。
9. beforeDestroy：实例销毁之前调用。在这一步，实例仍然完全可用。
10. destroyed：Vue 实例销毁后调用。调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。