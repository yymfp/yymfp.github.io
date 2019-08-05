---
title: Vue与React异同
date: 2019-04-28 12:34:49
tags: Vue
categories: 前端
---

### vue与React异同

##### 相同点

1. 都有组件化开发和Virtual DOM
2. 都支持props进行父子组件间数据通信
3. 都支持数据驱动视图，不直接操作真实DOM，更新状态数据界面就自动更新
4. 都支持服务器端渲染
5. 都有支持native的方案，React的React Native，Vue的Weex

##### 不同点

1. 数据绑定：vue实现了数据的双向绑定，react数据流是单向的
2. 组件的写法不一样，React推荐的做法是JSX，也就是把HTML和CSS全都写进JavaScript了，即'all in js'；vue推荐的做法是webpack+vue+loader的单文件组件格式，即html,css,js写在同一个文件
3. state对象在react应用中不可变的，需要使用setState方法更新状态；在vue中，state对象不是必须的，数据由data属性在vue对象中管理
4. virtual DOM不一样，vue会跟踪每一个组件的依赖关系，不需要重新渲染整个组件树。而对与React而言，每当应用的状态被改变时，全部组件都会重新渲染，所以react中会需要shouldComponentUpdate这个生命周期函数方法来进行控制
5. React严格上只针对MVC的view层，Vue则是MVVM模式