---
title: less
date: 2019-06-08 13:59:34
tags: css
categories: 前端
---

### less

less是一种动态样式语言，属于css预处理器的范畴，它扩展了css语言，增加了变量、Mixin、函数等特性，使css更易于维护和扩展。

**Less即可以在客户端上运行，也可以借助Node.js在服务端运行**

##### Less中的注释

- 以//开头的注释，不会被编译到css文件中。
- 以/**/包裹的注释会被编译到css文件中。

##### less中的变量

使用@来申明一个变量:@pink:pink

1. 作为普通属性值来使用：直接使用@pink

2. 作为选择器和属性：#@{selector的值}的形式

3. 作为URL：@{url}

4. 变量的延迟加载

   ```less
   // less也拥有块级作用域{}
   @var: 0;
   .class {
       @var: 1;
       .brass {
           @var: 2;
           three: @var;  // 3
           @var: 3;
       }
       one: @var;
   }
   ```

   

##### less中的嵌套规则

1. 基本嵌套规则

2. &的使用

   ```less
   // &代表平级
   /*
   	<div class="wrap">
   		<div class="inner"></div>
   	</div>
   */
   @color:deepink;   // 定义变量	
   #wrap{
       position: relative;
       width: 300px;
       height: 400px;
       border: 1px solid;
       margin: 0 auto;
       .inner{
           position: absolute;
           left: 0;
           right: 0;
           top: 0;
           bottom: 0;
           margin: auto;
           background: @color;
           height: 100px;
           width: 100px;
           &:hover{  // 最终解析出来的是 #wrap .inner:hover 如果不加&符号，#wrap .inner :hover
               background: pink;
           }
       }
   }
   ```

   

##### less中的混合

混合就是将一系列属性从一个规则集引入到另一个规则集的方式

1. 普通混合
2. 不带输出的混合
3. 带参数的混合
4. 带参数并且有默认值的混合
5. 带多个参数的混合
6. 命名参数
7. 匹配模式
8. arguments变量

```less
#wrap{
    position: relative;
    width: 300px;
    height: 400px;
    border: 1px solid;
    margin: 0 auto;
    .inner{
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        margin: auto;
        background: deeppink;
    	width: 100px;
    	height: 100px;
    }
    .inner2{
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        margin: auto;
        background: deeppink;
    	width: 100px;
    	height: 100px;
    }
}
// 普通混合 ---> 编译后，不会被删除
.juzhong{
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    margin: auto;
    background: deeppink;
    width: 100px;
    height: 100px;
}
// 不带输出混合 ---> 编译后，不会显示
.juzhong(){
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    margin: auto;
    background: deeppink;
    width: 100px;
    height: 100px;
}
// 带参数混合 ---> 使用.juzhong(100px,100px,deeppink)
.juzhong(@w,@h,@c){
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    margin: auto;
    background: @c;
    width: @w;
    height: @h;
}
#wrap{
    position: relative;
    width: 300px;
    height: 400px;
    border: 1px solid;
    margin: 0 auto;
    .inner{
       .juzhong;
    }
    .inner2{
        .juzhong;
    }
}
```

##### less运算

在less中可以进行加减乘除的运算

```less
#wrap .sjx{
    width:(100 + 100px);  // 只需一方带单位即可
}
```

##### less避免编译

```less
.div{
    margin: 100px;
    padding: ~"cacl(100px + 100px)"; // ~""将被识别为字符串，不会被编译
}
```



##### less继承

1. 性能比混合高
2. 灵活度比混合低

```less
.juzhong{ // 继承不能使用参数
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    margin: auto;
}
#wrap{
    position: relative;
    width: 300px;
    height: 400px;
    border: 1px solid;
    margin: 0 auto;
    .inner:extend(.juzhong){  // 继承
        background: deeppink;
    	width: 100px;
    	height: 100px;
    }
}
```

