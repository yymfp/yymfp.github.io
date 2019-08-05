---
title: css性能调优
date: 2018-10-11 11:27:12
tags: 前端性能相关
categories: 前端
---

### css性能调优

1. ##### 通过style标签的相关调优

   使用link标签引入css文件，而不是用@import，原因是link标签放在head标签中，在页面加载前将相关css样式渲染到浏览器，@import则在页面加载之后进行渲染。

2. ##### 避免使用表达式

   避免使用expression相关表达式。

3. ##### css缩写

   例如：margin:20px;（上下左右都设置20px）

4. ##### css声明

   ```css
   .div1{
       width:200px;
       height:200px;
   }
   .div2{
       width:200px;
       height:200px;
   }
   .div3{
       width:200px;
       height:200px;
   }
   /*声明优化*/
   .div1 .div2 .div3{
       width:200px;
       height:200px;
   }
   ```

5. ##### css选择器

   1. 浏览器的匹配规则是：从右到左匹配查找。

   2. 避免过长的规则例如：div>table>tr>td .classname等等。
   3. 避免使用：[hidden="true"]。
   4. 尽量使用继承，避免重复的样式。

   > 参考其他资料得到的一个效率排序：
   >
   > 1.id选择器（#myid）
   > 2.类选择器（.myclassname）
   > 3.标签选择器（div,h1,p）
   > 4.相邻选择器（h1+p）
   > 5.子选择器（ul < li）
   > 6.后代选择器（li a）
   > 7.通配符选择器（*）
   > 8.属性选择器（a[rel="external"]）
   > 9.伪类选择器（a:hover,li:nth-child）
