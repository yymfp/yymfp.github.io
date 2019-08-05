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