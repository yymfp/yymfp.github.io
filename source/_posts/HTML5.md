---
title: HTML5
date: 2018-10-11 14:01:39
tags: HTML
categories: 前端
---

### HTML5

**使用HTML5新增的标签，可以让HTML代码结构看起来更加清晰明了，维护起来更加方便，阅读性更高。**

##### 标签：

```html
<header>
	header元素表示页面中的一个内容区块或者整个页面的标题
</header>
<nav>
	nav标签表示页面中导航的部分
</nav>
<article>
	article标签表示页面中的一块与上下文不相关的独立内容，比如一篇文章
</article>
<section>
	section标签表示页面中一块内容区域，比如章节的页眉、页脚
</section>
<aside>
	aside标签表示article元素的内容之外的，和内容相关的辅助信息
</aside>
<footer>
	footer标签表示页面或者页面中的一块区域的页脚，比如存放文件的创建时间、作者、联系方式等
</footer>
```

##### 废除的标签：

1. 能使用css代替的元素：basefont、big、center、font、s、strike、tt、u
2. 不在使用frame框架
3. 只有部分浏览器支持的元素：applet、bgsound、blink、marquee
4. 其他被废除的元素：rb使用ruby代替，acronym使用abbr代替

- DOCTYPE声明     在html5中，刻意不使用版本声明，一份文档将会适用于所有版本的Html(不区分大小写，引号不区分单引号或双引号)

  ```html
  <DOCTYPE html>
  ```

- 指定字符编码

  ```html
  <meta charset="UTF-8">
  ```

- 可以省略标记的元素

  1. 不允许写结束 标记的元素有：area、base、br、col、command、embed、hr、img、input、keygen、link、meta、param、source、track、wbr。

  2. 可以省略结束标记的元素有：li、dt、dd、p、rt、rp、optgroup、option、colgroup、thead、tbody、tfoot、tr、td、th。

  3. 可以省略全部标记的元素有：html、head、body、colgroup、tbody。

     >"不允许写结束标记的元素"是指，不允许使用开始标记与结束标记将元素括起来的形式，只允许使用"<元素/>"的形式进行书写。例如"\<br>…\<br/>"的书写方式是错误的，正确的书写方式为"\<br/>"。当然也可以“\<br>”。
     >
     >"可以省略全部标记的元素"是指，该元素可以完全被省略。即使标记被省略，该元素还是以隐式的方式存在的。例如将body元素省略，但它在文档结构中依然存在，也可以通过js的dom获取到。

- 具有boolean指的属性

  ```html
  <!--只写属性不写属性值代表属性为true -->
  <input type="checkbox" checked>
  <!--不写属性代表属性为false -->
  <input type="checkbox">
  <!--属性值等于属性名时，代表属性为true -->
  <input type="checkbox" checked="checked">
  <!--属性值为空字符串时，代表属性为true -->
  <input type="checkbox" checked="">
  ```

- 新增的结构元素

  1. section：表示页面中的一个内容区块，比如章节、页眉、页脚或页面中的其他部分。可以结合h1-h6来使用。

  2. article：表示页面中的一块与上下文不相关的独立内容，比如博客中的一篇文章或报纸中的一篇文章。

  3. aside：表示article元素内容之外的、与article元素的内容相关的辅助信息。

  4. header：表示页面中一个内容区块或整个页面的标题。

  5. hgroup：表示用于对整个页面或页面中一个内容区块的标题进行组合。

  6. footer：表示整个页面或者页面中一个内容区块的脚注。

  7. nav：表示页面中导航链接的部分。

  8. figure：表示一段独立的流内容，一般表示文档主体流内容中的一个独立单元。

     ```html
     <figure>
         <p>
             The People's Republic of China was born in 1949...
         </p>
     </figure>
     ```

  **article元素与section区别：**

  >article元素可以看成是一种特殊种类的section元素，它比section元素更强调独立性。section元素强调分段或分块，而article强调独立性。如果一块内容相对来说比较独立、完整的时候，应该使用article元素，但如果想将一块内容分成几段时，应该使用section元素。

- 新增其他元素

  1. video：用于定义视频。

     ```html
     <video src="movie.mp4" controls>video元素</video>
     ```

  2. audio：用于定义音频。

     ```html
     <audio src="someaudio.wav">audio元素</audio>
     ```

  3. embed：用来插入各种多媒体，格式可以是Midi、Wav、AIFF、AU、MP3等。

     ```html
     <embed src="horse.wav">
     ```

  4. mark：用来在视觉上向用户呈现那些需要突出显示或高亮显示的文字。

     ```html
     <mark></mark>
     ```

  5. progress：表示运行中的进程。

  6. time：表示日期或时间。

  7. canvas：表示图形。这个元素本身没有行为，仅提供一块画布，提供绘图API给客户端JavaScript。

  8. menu：表示菜单列表。

- 新增表单相关属性

  1. 可以对input（type=text）、select、textarea与button元素指定autofocus属性。以指定属性的方式让元素在画面打开时自动获取焦点。
  2. 可以对Input元素与textarea元素指定placeholder属性，可以用来提示用户输入内容。
  3. 可以对input元素（type=text）与textarea元素指定required属性。该属性表示在用户提交的时候进行检查，检查该元素内一定要有输入内容。
  4. 为input元素添加可几个新的属性：autocomplete、min、max、multiple、pattern与step。

- 其他属性

  1. 为ol元素增加属性reversed,它指定列表倒序显示。
  2. 为menu元素增加两个新属性—— type与label。label属性为菜单定义一个可见的标注，type属性让菜单可以以上下文菜单、工具条与列表菜单的三种形式表现。
  3. 为style元素增加scoped属性，用来规定样式的作用范围。
  4. 为script元素增加async属性，定义脚本是否异步执行。

- 全局属性

  1. contentEditable属性：允许用户编辑元素中的内容。该属性是一个布尔值，可以指定true或false。通过inherit(继承)状态，来指定子元素是否允许编辑。
  2. designMode属性：用来指定整个页面是否可编辑。只能在JavaScript脚本里被编辑修改。on代表可编辑，off不可编辑。
  3. hidden属性：在html5中，所有元素都允许使用一个hidden属性，通知浏览器不渲染该元素，使该元素处于不可见状态。
  4. spellcheck：html5针对input元素(type=text)与textarea这两个文本输入元素提供的属性，功能是对用户输入的文本内容进行拼写和语法检查。它在书写时有一个特殊的地方，就是必须明确声明属性值为true或false。