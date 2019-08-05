---
title: vue自定义指令
date: 2019-04-24 12:34:43
tags: Vue
categories: 前端
---

### vue自定义指令用法

##### 可以通过`Vue.directive`来定义全局指令
```javaScript
// 注册一个全局自定义指令 `v-focus`
Vue.directive('focus', {
  // 当被绑定的元素插入到 DOM 中时……
  inserted: function (el) {
    // 聚焦元素
    el.focus()
  }
})
```
##### 如果想注册局部指令，组件中也接受`directives`选项

```javaScript
directives: {
  focus: {
    // 指令的定义
    inserted: function (el) {
      el.focus()
    }
  }
}
```
##### 可以在模板中任何元素上使用`v-focus`

```html
<input v-focus>
```
##### 提供的钩子函数
- bind：只调用一次，指令第一次绑定到元素时调用。在这里可以进行一次性的初始化设置。

- inserted：被绑定元素插入父节点时调用 (仅保证父节点存在，但不一定已被插入文档中)。

- update：所在组件的 VNode 更新时调用，但是可能发生在其子 VNode 更新之前。指令的值可能发生了改变，也可能没有。但是你可以通过比较更新前后的值来忽略不必要的模板更新 (详细的钩子函数参数见下)。

- componentUpdated：指令所在组件的 VNode 及其子 VNode 全部更新后调用。

- unbind：只调用一次，指令与元素解绑时调用。

- 接下来我们来看一下钩子函数的参数 (即 el、binding、vnode 和 oldVnode)。

##### 钩子函数参数
- el：指令所绑定的元素，可以用来直接操作 DOM 。

- binding：一个对象，包含以下属性：
    name：指令名，不包括 v- 前缀。

    1. value：指令的绑定值，例如：v-my-directive="1 + 1" 中，绑定值为 2。

    2. oldValue：指令绑定的前一个值，仅在 update 和 componentUpdated 钩子中可用。无论值是否改变都可用。

    3. expression：字符串形式的指令表达式。例如 v-my-directive="1 + 1" 中，表达式为 "1 + 1"。

    4. arg：传给指令的参数，可选。例如 v-my-directive:foo 中，参数为 "foo"。

    5. modifiers：一个包含修饰符的对象。例如：v-my-directive.foo.bar 中，修饰符对象为 { foo: true, bar: true }。

- vnode：Vue 编译生成的虚拟节点。

- oldVnode：上一个虚拟节点，仅在 update 和 componentUpdated 钩子中可用。

> 除了 el 之外，其它参数都应该是只读的，切勿进行修改。如果需要在钩子之间共享数据，建议通过元素的 dataset 来进行。

##### 通过全局指令实现img默认图片


```javaScript
//默认图片
Vue.directive('defaultImg', {
    bind: function(el) {
        //在图片加载失败时执行onerror
        el.onerror = function(){
            el.src = require('../src/assets/images/pic_small.png');
        }
    }
})

```