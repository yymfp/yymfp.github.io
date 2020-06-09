---
title: position属性
date: 2018-10-18 13:19:20
tags: css
categories: 前端
---

### position属性

**该属性规定元素的定位类型**

> 语法：`position:absolute | relative | fixed | static | interit;`
>
> - absolute：生成绝对定位的元素，相对于static定位以外的第一个父元素进行定位。（left、top、right、bottom）
> - fixed：生成绝对定位的元素，相对于浏览器窗口进行定位。（left、top、right、bottom）
> - relative：生成相对定位的元素，相对于其正常位置进行定位。
> - static：默认值。没有定位，元素出现在正常的流中。（忽略 top, bottom, left, right 或者 z-index 声明）
> - inherit：规定应该从元素继承position属性的值。

对于定位的主要问题是要记住每种定位的意义。所以，现在让我们复习一下学过的知识吧：相对定位是“相对于”元素在文档中的初始位置，而绝对定位是“相对于”最近的已定位祖先元素，如果不存在已定位的祖先元素，那么“相对于”最初的包含块。

**注释：**根据用户代理的不同，最初的包含块可能是画布或 HTML 元素。