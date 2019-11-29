---
title: Vue数据绑定Dep与Watcher之间的关系
date: 2019-11-29 10:54:08
tags: Vue
categories: 前端
---

### Vue数据绑定dep与Watcher之间的关系

- ##### **Dep**

  1. 实例创建时机：初始化时，给data的属性进行数据劫持时创建的。

  2. 个数：与data中的属性一一对应。

  3. 结构：

     id: 标识

     Subs: [] n个相关的watcher的容器

- ##### **Watcher**

  1. 实例创建的时机：初始化解析大括号表达式/一般指令时创建

  2. 个数：与模板中表达式（包括一般指令单不包括事件指令）一一对应

  3. 结构：

     this.cb = cb; // 用于更新界面的回调

     this.vm = vm; // vm

     this.exp = exp; // 对应的表达式

     this.depIds = {depid, dep}; //相关的n个dep的容器对象

     this.value = this.get(); // 当前表达式对应的value

- ##### **Dep与Watcher之间的关系**

  - 多对多的关系

    data属性 --> Dep -->n个Watcher（模板中有多个表达式使用了此属性： {{name}}/v-text="name"）

    表达式 --> Watcher --> n个Dep（多层表达式： a.b.c）

  - 什么时候建立

    初始化解析模板中的表达式创建Watcher对象时建立