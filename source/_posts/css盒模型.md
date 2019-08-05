---
title: css盒模型
date: 2018-10-11 17:58:23
tags: css
categories: 前端
---

### css盒模型

**css盒模型组成：content区域+margin+padding+border。**

> **css3的box-sizing：**
>
> ## 语法
>
> ```css
> box-sizing: content-box|border-box|inherit;
> ```
>
> | 值          | 描述                                                         |
> | ----------- | ------------------------------------------------------------ |
> | content-box | 这是由 CSS2.1 规定的宽度高度行为。宽度和高度分别应用到元素的内容框。在宽度和高度之外绘制元素的内边距和边框。 |
> | border-box  | 为元素设定的宽度和高度决定了元素的边框盒。就是说，为元素指定的任何内边距和边框都将在已设定的宽度和高度内进行绘制。通过从已设定的宽度和高度分别减去边框和内边距才能得到内容的宽度和高度。 |
> | inherit     | 规定应从父元素继承 box-sizing 属性的值。                     |



##### css的盒模型分为两种

1. W3C标准盒模型
2. IE标准盒模型

市面上大多数浏览器都采用W3C标准的盒模型。

由于标准不同，所以就产生了两种盒模型。

```html
<style>
	.hz{
			width:100px;
			height:100px;
			box-sizing: content-box;	/*标准模式：content-box  怪异模式：border-box*/
			background:red;
			margin:10px;
			padding:10px;
			border:1px solid #ccc;
		}
</style>
<div class="hz">		
</div>
```



1. ##### 标准盒模型

   一个块元素的总宽度/总高度=width/height+padding+margin+border

   ![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/11/0754b65440c0fe40808b6481d881c0d2.png)

2. ##### 怪异盒模型

   一个块元素的总宽度/总高度=width/height+margin=内容区宽度/高度+padding+margin+border

![](http://bmob-cdn-8350.b0.upaiyun.com/2018/10/11/7018d20d4024c8748094ee6c656cbc13.png)