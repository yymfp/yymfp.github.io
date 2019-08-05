---
title: css3新增的常见属性
date: 2018-10-11 18:51:38
tags: css
categories: 前端
---

### css3新增属性

1. ##### css3 边框

   - border-radius：该属性允许为元素添加圆角边框

     > 语法：
     >
     > ```css
     > border-radius:1-4 length;
     > ```
     >
     > 1-4：四个方向，可以只设置一个所有都生效。

   - box-shadow：为方框添加一个或多个阴影

     > 语法：
     >
     > ```css
     > box-shadow: h-shadow v-shadow blur spread color inset;
     > ```
     >
     > h-shadow：水平阴影的位置。（必需）
     >
     > v-shadow：垂直阴影的位置。（必需）
     >
     > blur：模糊距离。（可选）
     >
     > spread：阴影的尺寸。（可选）
     >
     > color：阴影的颜色。（可选）
     >
     > inset：将外部阴影改为内部阴影。（可选）

   - border-image：该属性规定用于边框的图片

     > 定义和用法：
     >
     > border-image 属性是一个简写属性，用于设置以下属性：
     >
     > - border-image-source：用在边框的图片的路径
     > - border-image-slice：图片边框向内偏移。
     > - border-image-width：图片边框的宽度。
     > - border-image-outset：边框图像区域超出边框的量。
     > - border-image-repeat：图像边框是否应平铺(repeated)、铺满(rounded)或拉伸(stretched)。

2. ##### css3 背景

   - background-size：规定背景图片的尺寸。

     > 语法：
     >
     > ```css
     > background-size:length|percentage|cover|contain;
     > ```
     >
     > | 值         | 描述                                                         |
     > | ---------- | ------------------------------------------------------------ |
     > | length     | 设置背景图片的高度和宽度，第一个值设置宽度，第二个设置高度。如果只设置一个值，则第二个值被设为auto |
     > | percentage | 以父元素的百分比来设置背景图片的宽高。同上                   |
     > | cover      | 把北京图像扩展至足够大，以使背景图像完全覆盖背景区域         |
     > | contain    | 把图像扩展至最大尺寸，以使其宽高完全适应内容区域             |
     >
     >

   - background-clip：规定背景的绘制区域。

     > 语法：
     >
     > ```css
     > background-clip:border-box|padding-box|content-box;
     > ```
     >
     > | 值          | 描述                 |
     > | ----------- | -------------------- |
     > | border-box  | 背景被裁剪到边框盒   |
     > | padding-box | 背景被裁剪到内边距框 |
     > | content-box | 背景被裁剪到内容框   |

   - background-origin：规定背景图片的定位区域。

     > 语法：
     >
     > ```css
     > background-origin:padding-box|border-box|content-box;
     > ```
     >
     > | 值          | 描述                           |
     > | ----------- | ------------------------------ |
     > | padding-box | 背景图像相对于内边距框来定位。 |
     > | border-box  | 背景图像相对于边框盒来定位。   |
     > | content-box | 背景图像相对于内容框来定位。   |

3. ##### css3 文本效果

   - text-shadow：向文本添加阴影

     > 语法：
     >
     > ```css
     > text-shadow: h-shadow v-shadow blur color;
     > ```
     >
     > | 值         | 描述                             |
     > | ---------- | -------------------------------- |
     > | *h-shadow* | 必需。水平阴影的位置。允许负值。 |
     > | *v-shadow* | 必需。垂直阴影的位置。允许负值。 |
     > | *blur*     | 可选。模糊的距离。               |
     > | *color*    | 可选。阴影的颜色。               |

   - word-wrap：允许对长的不可分割的单词进行分割并换行到下一行。

     > 语法：
     >
     > ```css
     > word-wrap: normal|break-word;
     > ```
     >
     > | 值         | 描述                                         |
     > | ---------- | -------------------------------------------- |
     > | normal     | 只在允许的断字点换行（浏览器保持默认处理）。 |
     > | break-word | 在长单词或 URL 地址内部进行换行。            |

4. ##### css3 字体

   @font-face规则：使用这个规则后，可以将想要使用的字体放到服务器中，它会在需要时被用户自动下载到本地计算机。

   ```css
   @font-face{
    font-family: myfirstFont;		/*必需规定的字体的名称*/
    src:url('Sansation_Light.ttf'),	/*定义字体的URL*/
        url('Sansation_Light.eot'); /* IE9+ */
   }
   div{
       font-family:myfirstFont;	/*使用自己定义的字体*/
   }
   ```

5. ##### css3 2D转换

   - transform：向元素应用2D或3D转换

     ## 实例

     旋转 div 元素：

     ```css
     div
     {
     transform:rotate(7deg);
     -ms-transform:rotate(7deg); 	/* IE 9 */
     -moz-transform:rotate(7deg); 	/* Firefox */
     -webkit-transform:rotate(7deg); /* Safari 和 Chrome */
     -o-transform:rotate(7deg); 	/* Opera */
     }
     ```

   - transform-origin：允许改变被转换元素的位置（必需配合transform使用）

     > 语法：
     >
     > ```css
     > transform-origin: x-axis y-axis z-axis;
     > ```
     >
     > | 值     | 描述                                                         |
     > | ------ | ------------------------------------------------------------ |
     > | x-axis | 定义视图被置于 X 轴的何处。可能的值：leftcenterright*length**%* |
     > | y-axis | 定义视图被置于 Y 轴的何处。可能的值：topcenterbottom*length**%* |
     > | z-axis | 定义视图被置于 Z 轴的何处。可能的值：*length*                |
     >
     > ## 实例
     >
     > 设置旋转元素的基点位置：
     >
     > ```css
     > div
     > {
     > transform: rotate(45deg);
     > transform-origin:20% 40%;
     > 
     > -ms-transform: rotate(45deg); 		/* IE 9 */
     > -ms-transform-origin:20% 40%; 		/* IE 9 */
     > 
     > -webkit-transform: rotate(45deg);	/* Safari 和 Chrome */
     > -webkit-transform-origin:20% 40%;	/* Safari 和 Chrome */
     > 
     > -moz-transform: rotate(45deg);		/* Firefox */
     > -moz-transform-origin:20% 40%;		/* Firefox */
     > 
     > -o-transform: rotate(45deg);		/* Opera */
     > -o-transform-origin:20% 40%;		/* Opera */
     > }
     > ```

   - translate(x,y)：定义 2D 转换，沿着 X 和 Y 轴移动元素。

   - rotate(angle)：定义 2D 旋转，在参数中规定角度。

   - scale(x,y)：定义 2D 缩放转换，改变元素的宽度和高度。

   - skew(x-angle,y-angle)：定义 2D 倾斜转换，沿着 X 和 Y 轴。

   - matrix(*n*,*n*,*n*,*n*,*n*,*n*)：定义 2D 转换，使用六个值的矩阵。

6. ##### css3 3D转换

   - transform-style：规定被嵌套元素如何在 3D 空间中显示

     > 语法：
     >
     > ```css
     > transform-style: flat|preserve-3d;
     > ```
     >
     > | 值          | 描述                       |
     > | ----------- | -------------------------- |
     > | flat        | 子元素将不保留其 3D 位置。 |
     > | preserve-3d | 子元素将保留其 3D 位置。   |
     >
     > ## 实例
     >
     > 使被转换的子元素保留其 3D 转换：
     >
     > ```css
     > div
     > {
     > transform: rotateY(60deg);
     > transform-style: preserve-3d;
     > -webkit-transform: rotateY(60deg);	/* Safari 和 Chrome */
     > -webkit-transform-style: preserve-3d;	/* Safari 和 Chrome */
     > }
     > ```

   - perspective：规定 3D 元素的透视效果(目前浏览器都不支持 perspective 属性。Chrome 和 Safari 支持替代的 -webkit-perspective 属性)

     > 语法：
     >
     > ```css
     > perspective: number|none;
     > ```
     >
     > | 值       | 描述                            |
     > | -------- | ------------------------------- |
     > | *number* | 元素距离视图的距离，以像素计。  |
     > | none     | 默认值。与 0 相同。不设置透视。 |
     >
     > ## 实例
     >
     > 设置元素被查看位置的视图：
     >
     > ```css
     > div
     > {
     > perspective: 500;
     > -webkit-perspective: 500; /* Safari 和 Chrome */
     > }
     > ```

   - perspective-origin：规定 3D 元素的底部位置

     > 语法:
     >
     > ```css
     > perspective-origin: x-axis y-axis;
     > ```
     >
     > | 值       | 描述                                                         |
     > | -------- | ------------------------------------------------------------ |
     > | *x-axis* | 定义该视图在 x 轴上的位置。默认值：50%。可能的值：leftcenterright*length**%* |
     > | *y-axis* | 定义该视图在 y 轴上的位置。默认值：50%。可能的值：topcenterbottom*length**%* |
     >
     > ## 实例
     >
     > 设置 3D 元素的基点位置：
     >
     > ```css
     > div
     > {
     > perspective:150;
     > perspective-origin: 10% 10%;
     > -webkit-perspective:150;	/* Safari 和 Chrome */
     > -webkit-perspective-origin: 10% 10%;	/* Safari 和 Chrome */
     > }
     > ```

   - backface-visibility：定义元素在不面对屏幕时是否可见

     >语法:
     >
     >```css
     >backface-visibility: visible|hidden;
     >```
     >
     >| 值      | 描述             |
     >| ------- | ---------------- |
     >| visible | 背面是可见的。   |
     >| hidden  | 背面是不可见的。 |
     >
     >## 实例
     >
     >隐藏被旋转的 div 元素的背面：
     >
     >```css
     >div
     >{
     >backface-visibility:hidden;
     >-webkit-backface-visibility:hidden;	/* Chrome 和 Safari */
     >-moz-backface-visibility:hidden; 	/* Firefox */
     >-ms-backface-visibility:hidden; 	/* Internet Explorer */
     >}
     >```

7. ##### css3 过渡

   - transition：简写属性，用于在一个属性中设置四个过渡属性。

     > 语法：
     >
     > ```css
     > transition: property duration timing-function delay;
     > ```
     >
     > | 值                         | 描述                                |
     > | -------------------------- | ----------------------------------- |
     > | transition-property        | 规定设置过渡效果的 CSS 属性的名称。 |
     > | transition-duration        | 规定完成过渡效果需要多少秒或毫秒。  |
     > | transition-timing-function | 规定速度效果的速度曲线。            |
     > | transition-delay           | 定义过渡效果何时开始。              |
     >
     > ### 实例
     >
     > 应用于宽度属性的过渡效果，时长为 2 秒：
     >
     > ```css
     > div
     > {
     > transition: width 2s;
     > -moz-transition: width 2s;	/* Firefox 4 */
     > -webkit-transition: width 2s;	/* Safari 和 Chrome */
     > -o-transition: width 2s;	/* Opera */
     > }
     > div:hover
     > {
     > width:300px;
     > }
     > ```

8. ##### css3 动画

   - @keyframes：规定动画

     > 语法：
     >
     > ```css
     > @keyframes animationname {
     >     keyframes-selector {'css-styles';}
     > }
     > ```
     >
     > | 值                   | 描述                                                         |
     > | -------------------- | ------------------------------------------------------------ |
     > | *animationname*      | 必需。定义动画的名称。                                       |
     > | *keyframes-selector* | 必需。动画时长的百分比。合法的值：0-100%from（与 0% 相同）to（与 100% 相同） |
     > | *css-styles*         | 必需。一个或多个合法的 CSS 样式属性。                        |

   - animation：所有动画属性的简写属性，除了 animation-play-state 属性。

     > 语法：
     >
     > ```css
     > animation: name duration timing-function delay iteration-count direction;
     > ```
     >
     > | 值                          | 描述                                     |
     > | --------------------------- | ---------------------------------------- |
     > | *animation-name*            | 规定需要绑定到选择器的 keyframe 名称。。 |
     > | *animation-duration*        | 规定完成动画所花费的时间，以秒或毫秒计。 |
     > | *animation-timing-function* | 规定动画的速度曲线。                     |
     > | *animation-delay*           | 规定在动画开始之前的延迟。               |
     > | *animation-iteration-count* | 规定动画应该播放的次数。                 |
     > | *animation-direction*       | 规定是否应该轮流反向播放动画。           |
     >
     > ## 实例
     >
     > ```css
     > @keyframes myfirst
     > {
     > from {background: red;}
     > to {background: yellow;}
     > }
     > 
     > @-moz-keyframes myfirst /* Firefox */
     > {
     > from {background: red;}
     > to {background: yellow;}
     > }
     > 
     > @-webkit-keyframes myfirst /* Safari 和 Chrome */
     > {
     > from {background: red;}
     > to {background: yellow;}
     > }
     > 
     > @-o-keyframes myfirst /* Opera */
     > {
     > from {background: red;}
     > to {background: yellow;}
     > }
     > div
     > {
     > animation: myfirst 5s;
     > -moz-animation: myfirst 5s;	/* Firefox */
     > -webkit-animation: myfirst 5s;	/* Safari 和 Chrome */
     > -o-animation: myfirst 5s;	/* Opera */
     > }
     > ```

9. ##### css3多列

   - column-count：属性规定元素应该被分隔的列数。

     > 语法：
     >
     > ```css
     > column-count: number|auto;
     > ```
     >
     > | 值       | 描述                                      |
     > | -------- | ----------------------------------------- |
     > | *number* | 元素内容将被划分的最佳列数。              |
     > | auto     | 由其他属性决定列数，比如 "column-width"。 |
     >
     > ### 实例
     >
     > 把 div 元素中的文本分隔为三列：
     >
     > ```css
     > div
     > {
     > -moz-column-count:3; 	/* Firefox */
     > -webkit-column-count:3; /* Safari 和 Chrome */
     > column-count:3;
     > }
     > ```

   - column-gap：属性规定列之间的间隔。

     > 语法：
     >
     > ```css
     > column-gap: length|normal;
     > ```
     >
     > | 值       | 描述                                               |
     > | -------- | -------------------------------------------------- |
     > | *length* | 把列间的间隔设置为指定的长度。                     |
     > | normal   | 规定列间间隔为一个常规的间隔。W3C 建议的值是 1em。 |
     >
     > ### 实例
     >
     > 规定列之间 40 像素的间隔：
     >
     > ```css
     > div
     > {
     > -moz-column-gap:40px;		/* Firefox */
     > -webkit-column-gap:40px;	/* Safari 和 Chrome */
     > column-gap:40px;
     > }
     > ```

   - column-rule：属性设置列之间的宽度、样式和颜色规则。

     > 语法：
     >
     > ```css
     > column-rule: column-rule-width column-rule-style column-rule-color;
     > ```
     >
     > | 值                  | 描述                   |
     > | ------------------- | ---------------------- |
     > | *column-rule-width* | 设置列之间的宽度规则。 |
     > | *column-rule-style* | 设置列之间的样式规则。 |
     > | *column-rule-color* | 设置列之间的颜色规则。 |
     >
     > ### 实例
     >
     > 规定列之间的宽度、样式和颜色规则：
     >
     > ```css
     > div
     > {
     > -moz-column-rule:3px outset #ff0000;	/* Firefox */
     > -webkit-column-rule:3px outset #ff0000;	/* Safari and Chrome */
     > column-rule:3px outset #ff0000;
     > }
     > ```

10. ##### css3 用户界面

    - resize：resize ：属性规定是否可由用户调整元素尺寸。

      > 语法：
      >
      > ```css
      > resize: none|both|horizontal|vertical;
      > ```
      >
      > | 值         | 描述                         |
      > | ---------- | ---------------------------- |
      > | none       | 用户无法调整元素的尺寸。     |
      > | both       | 用户可调整元素的高度和宽度。 |
      > | horizontal | 用户可调整元素的宽度。       |
      > | vertical   | 用户可调整元素的高度。       |
      >
      > ## 实例
      >
      > 规定可以由用户调整 div 元素的大小：
      >
      > ```css
      > div
      > {
      > resize:both;
      > overflow:auto;
      > }
      > ```

    - box-sizing：属性允许您以确切的方式定义适应某个区域的具体内容。

      > 语法：
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
      >
      > ## 实例
      >
      > 规定两个并排的带边框的框：
      >
      > ```css
      > div
      > {
      > box-sizing:border-box;
      > -moz-box-sizing:border-box; /* Firefox */
      > -webkit-box-sizing:border-box; /* Safari */
      > width:50%;
      > float:left;
      > }
      > ```

    - outline-offset：属性对轮廓进行偏移，并在超出边框边缘的位置绘制轮廓。

      > 语法：
      >
      > ```css
      > outline-offset: length|inherit;
      > ```
      >
      > | 值       | 描述                                         |
      > | -------- | -------------------------------------------- |
      > | *length* | 轮廓与边框边缘的距离。                       |
      > | inherit  | 规定应从父元素继承 outline-offset 属性的值。 |
      >
      > ## 实例
      >
      > 规定边框边缘之外 15 像素处的轮廓：
      >
      > ```css
      > div
      > {
      > border:2px solid black;
      > outline:2px solid red;
      > outline-offset:15px;
      > }
      > ```
      >
      > 轮廓在两方面与边框不同：
      >
      > - 轮廓不占用空间
      > - 轮廓可能是非矩形

**transition与animation最大的区别：**

transition需要事件触发，animation不需要。