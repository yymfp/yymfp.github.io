---
title: webpack
date: 2018-10-25 10:37:09
tags: webpack使用
categories: 前端
---

### webpack

##### 创建基本的webpack4.x项目

1. 运行`npm init -y`快速初始化项目
2. 在项目根目录创建`src`源代码目录和`dist`产品目录
3. 在`src`目录下创建`index.html`
4. 使用npm安装webpack，运行`cnpm i webpack webpack-cli -D`
   - 全局运行`npm i cnpm -g`

5. 注意：webpack4.x提供了约定大于配置的概念，目的是为了尽量减少配置文件的体积
   - 默认约定了：
   - 打包入口是`src`->`index.js`
   - 打包的输出文件是`dist`->`main.js`
   - 4.x中新增了`mode`选项（**必需**），可选的值为：`development`和`production`

**webpack的配置文件：**`webpack.config.js`:

```js
//向外暴露一个打包的配置对象， 因为webpack是基于Node构建的，所以webpack支持所有的Node API和语法
module.exports={
    mode:'production', //development production
    //在webpack 4.x中，有一个很大的特性，就是约定大于配置，默认的打包入口路径是src -> index.js
}
```

##### 安装webpack-dev-server

**命令：**`npm i webpack-dev-server -D`

在`package.json`中的`scripts`中添加`dev`选项：

```json
{
    ...
   "scripts":{
		...
    	"dev": "webpack-dev-server --open --port 3000"  //--open 自动打开浏览器 --port 指定端口
	} 
}
```

配置好之后，运行：`npm run dev`

**webpack-dev-server**打包好的`main.js`是托管到内存中的，所以在项目根目录中找不到。

##### 安装相关插件：

**命令：**`npm i html-webpack-plugin -D`

**作用：**将主页面生成到内存中去。

配置`webpack.config.js`文件：

```js
const path = require('path')
const HtmlWebPackPlugin = require('html-webpack-plugin') //导入 在内存中自动生成index页面的插件

//创建一个插件实例对象
const htmlPlugin = new HtmlWebPackPlugin({
    template: path.join(__dirname, './src/index.html'), //源文件
    filename: 'index.html' //生成的内存中首页名称
})

//向外暴露一个打包的配置对象， 因为webpack是基于Node构建的，所以webpack支持所有的Node API和语法
module.exports={
    mode:'production', //development production
    //在webpack 4.x中，有一个很大的特性，就是约定大于配置，默认的打包入口路径是src -> index.js
    plugins:[
        htmlPlugin
    ]
}
```

