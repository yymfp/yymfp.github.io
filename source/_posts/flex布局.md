---
title: flex布局
date: 2018-10-12 13:17:17
tags: css
categories: 前端
---

### flex布局

> 参考菜鸟教程

flex布局意为“弹性布局”，任何容器都可指定为flex布局。

```css
.div{
    display:flex;
}
/*行内元素*/
.div{
    display:inline-flex;
}
/*Webkit内核的浏览器*/
.div{
    display:-webkit-flex;
    display:flex;
}
```

**注意：设为flex布局以后，子元素的float、clear和vertical-align属性将失效。**

采用Flex布局的元素，称为Flex容器，它的所有子元素自动成为容器成员，称为flex项目。

![参考菜鸟教程](https://www.runoob.com/wp-content/uploads/2015/07/3791e575c48b3698be6a94ae1dbff79d.png)

> 说明：容器存在两根轴：水平的主轴和垂直的交叉轴。项目默认沿主轴排列。

##### flex-direction属性

> flex-direction属性决定主轴的方向（项目的排列方向）

语法：

```css
.div{
    flex-direction:row | row-reverse | column | column-reverse;
}
```

- row：主轴为水平方向，左为起点。
- row-reverse：主轴为水平方向，右为起点。
- column：主轴为垂直方向，上为起点。
- column-reverse：主轴为垂直方向，下为起点。

![参考菜鸟教程](https://www.runoob.com/wp-content/uploads/2015/07/0cbe5f8268121114e87d0546e53cda6e.png)

##### flex-wrap属性

> flex-wrap属性决定元素在一条轴线上排不下如何换行。

语法：

```css
.box{
  flex-wrap: nowrap | wrap | wrap-reverse;
}
```

- nowrap（默认）：不换行。
- wrap：换行，第一行在上方。
- wrap-reverse：换行，第一行在下方。

##### flex-flow

> flex-flow属性是flex-direction和flex-wrap属性的简写，默认值row nowrap。

##### justify-content属性

> justify-content属性规定项目在主轴上的对其方式。

语法：

```css
.div{
    justify-content:flex-start | flex-end | center | space-between | space-around
}
```

- flex-start：左对齐。
- flex-end：右对齐。
- center：居中。
- space-between：两端对齐，项目之间的间隔都相等。
- space-around：每个项目两侧的间隔相等。（注意：项目之间的间隔比项目与两边边框的间隔大一倍）

![参考菜鸟教程](https://www.runoob.com/wp-content/uploads/2015/07/c55dfe8e3422458b50e985552ef13ba5.png)

##### align-items属性

> align-items属性规定项目在交叉轴上如何对齐。

语法：

```css
.div{
    align-items:flex-start | flex-end | center | baseline | stretch;
}
```

- flex-start：假设交叉轴从上到下，从上开始对齐。
- flex-end：交叉轴的终点对齐。
- center：交叉轴的中点对齐。
- baseline：项目的第一行文字的基线对齐。
- stretch：如果项目未设置高度或为auto，将铺满整个容器高度。

![参考菜鸟教程](https://www.runoob.com/wp-content/uploads/2015/07/2b0c39c7e7a80d5a784c8c2ca63cde17.png)

##### align-content属性

> align-content属性定义多根轴线的对齐方式，若只有一根轴线，不起作用。

语法：

```css
.div{
    align-content:flex-start | flex-end | center | space-between | space-around | stretch;
}
```

- flex-start：与交叉轴的起点对齐。
- flex-end：与交叉轴的终点对齐。
- center：与交叉轴的中点对齐。
- space-between：与交叉轴两端对齐，轴线之间的间隔平均分布。
- space-around：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。
- stretch（默认值）：轴线占满整个交叉轴。

![](https://www.runoob.com/wp-content/uploads/2015/07/f10918ccb8a13247c9d47715a2bd2c33.png)

##### 项目属性

1. order属性：定义项目的排列顺序。数值越小排列越靠前，默认0。

   ```css
   .item{
       order:<integer>;
   }
   ```

   ![参考菜鸟教程](https://www.runoob.com/wp-content/uploads/2015/07/59e399c72daafcfcc20ede36bf32f266.png)

2. flex-grow属性：定义项目的放大比例，默认0。

   ```css
   .item{
       flex-grow:<number>; /*default 0*/
   }
   /*如果项目的值相同，则均分。*/
   ```

   ![参考菜鸟教程](https://www.runoob.com/wp-content/uploads/2015/07/f41c08bb35962ed79e7686f735d6cd78.png)

3. flex-shrink属性：定义项目的缩小比例，默认1。(负值对该属性无效)

   ```css
   .item{
       flex-shrink:<number>; /*default 1*/
   }
   ```

   ![参考菜鸟教程](https://www.runoob.com/wp-content/uploads/2015/07/240d3e960043a729bb3ff5e34987904f.jpg)

4. flex-basis属性：定义再分配多余空间时，项目占据的主轴空间。默认auto。

   ```css
   .item{
       flex-basis:<length> | auto; /*default auto*/
   }
   ```

5. flex属性：该属性时flex-grow、flex-shrink、flex-basis属性的简写。

   ```css
   .item{
       flex:none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
   }
   ```

   **建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。**

6. align-self属性：允许单个项目与其他项目不一样的对齐方式，可覆盖align-items属性。默认值auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch。

   ```css
   .item{
       align-self:auto| flex-start | flex-end | center | baseline | stretch;
   }
   ```

   **该属性可能取6个值，除了auto，其他都与align-items属性完全一致。**

