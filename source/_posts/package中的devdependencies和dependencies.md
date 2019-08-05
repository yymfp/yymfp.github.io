---
title: package中的devdependencies和dependencies
date: 2019-04-24 12:45:50
tags: Vue
categories: 前端
---

### package中的devdependencies和dependencies

##### devdependencies和dependencies

这两个配置代表的是项目中所需要的相关依赖模块插件，通过键值的方式来定义：


```json
"name": "webpack-react-express",
  "version": "0.2.0",
  "private": true,
  "dependencies": {
    "antd": "^2.13.11",
    "babel-polyfill": "^6.26.0",
    "base-64": "^0.1.0",
    "bluebird": "^3.5.1",
    "css-loader": "^0.28.7",
    "echarts": "^3.7.2",
  },
  "devDependencies": {
    "babel-core": "^6.26.0",
    "babel-loader": "^6.4.1",
    "babel-plugin-transform-class-properties": "^6.24.1",
    "babel-plugin-transform-runtime": "^6.23.0",
    "babel-polyfill": "^6.26.0",
    "babel-preset-es2015": "^6.24.1",
    "webpack": "^1.12.13",
    "webpack-hot-middleware": "^2.21.0"
  },
```
##### devDependencies
1. 内容：是一个对象，配置模块依赖的模块列表，key是模块名称，value是版本范围

2. 作用：该模块中所列举的插件属于开发环境的依赖（比如：测试或者文档框架等）

3. 部署来源：通过你npm install进行依赖安装时加上-save-dev，devDependencies对象中便会增加你所需要的插件的安装配置

    `npm install name -save-dev`
##### dependencies
1. 内容：是一个对象，配置模块依赖的模块列表，key是模块名称，value是版本范围

2. 作用：该模块中所列举的插件属于生产环境的依赖（程序正常运行需要加载的依赖）

3. 部署来源：通过你npm install进行依赖安装时加上-save，dependencies对象中便会增加你所需要的插件的安装配置
    `npm install name -save`

##### 安装依赖

1. 如果拿到别人的项目，需要安装之前package.json中devdependencies 和 dependencies两个模块下所列举的依赖，可以通过执行以下命令实现

    `npm install`

2. 如果拿到别人的项目，只需要安装之前package.json中dependencies 模块下所列举的依赖，可以通过执行以下命令实现

    `npm install packagename`

3. 如果拿到别人的项目，只需要安装之前package.json中devdependencies 模块下所列举的依赖，可以通过执行以下命令实现
    `npm install packagename -dev`
##### 删除依赖
1. npm uninstall "依赖名称"：删除依赖，但不会删除package.json的配置（即通过npm install依然可以安装该依赖），删除echarts依赖实例代码如下

    `npm uninstall echarts`

2. npm uninstall "依赖名称" --save-dev：删除依赖，同时删除package.json中devdependencies的配置,删除echarts依赖实例代码如下

    `npm uninstall echarts  --save-dev`

3. npm uninstall "依赖名称" --save：删除依赖，同时删除package.json中dependencies的配置,删除echarts依赖实例代码如下

    `npm uninstall echarts --save`