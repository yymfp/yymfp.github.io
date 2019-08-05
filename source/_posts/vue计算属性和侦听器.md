---
title: vue计算属性和侦听器
date: 2018-12-09 12:32:11
tags: Vue
categories: 前端
---

### Vue的计算属性和侦听器

> 在模板中使用表达式以及相关的逻辑，会使得模板看起来过重且难以维护。
>
> 对于任何的复杂逻辑，你都应当使用计算属性。

```jsx
<template>
    <div id="example">
      <p>Original message: "{{ message }}"</p>
      <p>Computed reversed message: "{{ reversedMessage }}"</p>
    </div>
</template>
<script>
	export default({
        data: {
            message: 'Hello'
        },
        computed: {
            // 计算属性的 getter
            reversedMessage: function () {
                // `this` 指向 vm 实例
                return this.message.split('').reverse().join('')
            }
        }
	})
</script>
```

使用计算属性时，直接使用相关的方法名，就可以得到相关的返回结果。

##### 计算属性vs方法

计算属性跟调用方法非常的类似

```jsx
<p>Reversed message: "{{ reversedMessage() }}"</p>
// 在组件中
methods: {
  reversedMessage: function () {
    return this.message.split('').reverse().join('')
  }
}
```

我们可以将同一个函数定义为方法而不是计算属性，两种方法得到的结果是完全相同的。**不同的是：计算属性是基于它们的依赖进行缓存的。**只有在相关的依赖发生变化时，它们才会重新求值。这就意味着只要 `message` 还没有发生改变，多次访问 `reversedMessage` 计算属性会立即返回之前的计算结果，而不必再次执行函数。

> 参考官方文档：[https://cn.vuejs.org/v2/guide/computed.html#计算属性](https://cn.vuejs.org/v2/guide/computed.html#%E8%AE%A1%E7%AE%97%E5%B1%9E%E6%80%A7)