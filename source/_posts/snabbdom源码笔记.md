---
title: snabbdom源码笔记
date: 2020-07-30 10:40:35
tags: Vue
categories: 前端
---

### Snabbdom源码笔记

- ##### **创建项目**

  ```bash
  # 创建项目目录
  mkdir snabbdom-demo
  # 进入项目
  cd snabbdom-demo
  # 创建 package.json
  npm init -y
  # 本地安装 parcel
  npm add parcel-bundler
  # 安装snabbdom
  npm i snabbdom
  ```

- ##### **配置package.json**

  ```js
  "script": {
    "dev": "parcel index.html --open",
    "build": "parcel build index.html"
  }
  ```

- ##### **创建目录结构**

  ```
  | index.html
  | package.json
  |-src
  				demo.js
  ```

- ##### **demo.js**

  ```js
  import { h, init } from 'snabbdom'
  // 导入模块
  import style from 'snabbdom/modules/style'
  import eventlisteners from 'snabbdom/modules/eventlisteners'
  
  let patch = init([style, eventlisteners])
  let vNode = h('div#container', {
      style: {
          backgroundColor: 'red',
      },
      on: {
          click: () => {
              console.log('hello word')
          }
      },
      hook: {
          init(vNode) {
              console.log(vNode)
          },
          create(emptyVnode, vNode) {
              console.log(emptyVnode)
          }
      }
  }, [
      h('h1', 'Hello World'),
      h('p', 'p 标签')
  ])
  let app = document.querySelector('#app')
  patch(app, vNode)
  ```

- ##### **init函数源码分析**

  - init函数接收一个modules的数组参数和用户自定义的domApi（可选）

    ```ts
    export function init (modules: Array<Partial<Module>>, domApi?: DOMAPI) {
      // ***
    }
    ```

  - 初始化cbs（存储回调钩子函数）

    ```ts
    const hooks: Array<keyof Module> = ['create', 'update', 'remove', 'destroy', 'pre', 'post']
    
    const cbs: ModuleHooks = {
        create: [],
        update: [],
        remove: [],
        destroy: [],
        pre: [],
        post: []
    }
    
    // 初始化所有的钩子函数结构
    for (i = 0; i < hooks.length; ++i) {
        cbs[hooks[i]] = []
      // 将传入模块的钩子函数添加到cbs对应的钩子函数结构中
        for (j = 0; j < modules.length; ++j) {
          const hook = modules[j][hooks[i]]
          if (hook !== undefined) {
            (cbs[hooks[i]] as any[]).push(hook)
          }
        }
     }
    ```

  - 判断domapi

    ```ts
    const api: DOMAPI = domApi !== undefined ? domApi : htmlDomApi
    ```

  - 返回patch函数

    ```js
    return function patch (oldVnode: VNode | Element, vnode: VNode): VNode {
      // ****
    }
    ```

    