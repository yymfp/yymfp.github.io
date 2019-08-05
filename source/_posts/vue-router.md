---
title: vue-router
date: 2018-10-20 14:41:41
tags: Vue
categories: 前端
---

### Vue-router

##### 路由的定义使用：

**HTML**

```html
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<div id="app">
  <h1>Hello App!</h1>
  <p>
    <!-- 使用 router-link 组件来导航. -->
    <!-- 通过传入 `to` 属性指定链接. -->
    <!-- <router-link> 默认会被渲染成一个 `<a>` 标签 -->
    <router-link to="/foo">Go to Foo</router-link>
    <router-link to="/bar">Go to Bar</router-link>
  </p>
  <!-- 路由出口 -->
  <!-- 路由匹配到的组件将渲染在这里 -->
  <router-view></router-view>
</div>
```

```js
//非模块化定义
//1.定义路由组件
const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }
//2.定义路由
const routes=[
    {
        path:'/foo',
        component:Foo
    },
    {
        path:'/bar',
        component:Bar
    }
]
//3.创建路由实例，将routes配置传入
const router=new VueRouter({
    routes  //相当于routes:routes
})
//4.创建和挂载根实例
const app =new Vue({
    router  //相当于router:router
}).$mount("#app")
```

```js
//模块化开发定义方式
// 0. 如果使用模块化机制编程，导入Vue和VueRouter，要调用 Vue.use(VueRouter)
import Vue from 'vue'
import VueRouter from 'vue-router'
import routes from './routes'
Vue.use(VueRouter)
//1.创建路由实例，将routes传入
const router=new VueRouter({
    mode:'history',
    routes
})
//文件./routes内容
const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }
const routes=[
    {
        path:'/foo',
        component:Foo
    },
    {
        path:'/bar',
        component:Bar
    }
]
```

**定义完成后，可以再组件内通过 `this.$router` 访问路由器，也可以通过 `this.$route` 访问当前路由：**

```js
//Foo.vue
export default{
    methods:{
        myRouter(){
            this.$router.push({
            	path:'/', //要跳转的路由位置
            })
        }
    }
}
```

##### 动态路由匹配

**路由传参：**

```js
const User={
	template:'<div>User{{ $route.params.id }}</div>'
}
const router=new VueRouter({
    routes:[
        {
            path:'/user/:id',
            component:User
        }
    ]
})
```

*一个路径参数使用“:”标记。当匹配到一个路由时，参数值会被设置到`this.$rote.params`。*

你可以在一个路由中设置多段“路径参数”，对应的值都会设置到 `$route.params` 中。例如：

| 模式                          | 匹配路径            | $route.params                        |
| ----------------------------- | ------------------- | ------------------------------------ |
| /user/:username               | /user/evan          | `{ username: 'evan' }`               |
| /user/:username/post/:post_id | /user/evan/post/123 | `{ username: 'evan', post_id: 123 }` |

除了 `$route.params` 外，`$route` 对象还提供了其它有用的信息，例如，`$route.query` (如果 URL 中有查询参数)、`$route.hash` 等等。你可以查看 [API 文档](https://router.vuejs.org/zh/api/#%E8%B7%AF%E7%94%B1%E5%AF%B9%E8%B1%A1) 的详细说明。

**注意：路由跳转时，原来的组件实例会被复用。因为两个路由都渲染同个组件，比起销毁再创建，复用则更加高效。这也就意味着，组件的生命周期钩子不会再被调用。**

复用组件时，可以`watch`（监测变化）`$route`对象：

```js
const User={
    template:'...',
    watch:{
        '$route' (to,from){
            //对路由变化做出响应
        }
    }
}
```

使用`beforeRouteUpdate`导航守卫：

```js
const User = {
  template: '...',
  beforeRouteUpdate (to, from, next) {
    // react to route changes...
    // don't forget to call next()
  }
}
```

**匹配优先级**

有时候，同一个路径可以匹配多个路由，此时，匹配的优先级就按照路由的定义顺序：谁先定义的，谁的优先级就最高。

##### 嵌套路由

app：

```html
<div id="app">
    <router-view></router-view>
</div>
```

*app这里的`<router-view>`是最顶层的出口。一个被渲染的组件同样可以包含自己嵌套的`<router-view>`。例如在`User`模板中添加`<router-view>`：*

```js
const User={
    template: `
		<div class="user">
			<h2>User {{$route.params.id}}</h2>
			<router-link to="/user/:id/posts">UserPosts</router-link>
			<router-link to="/user/:id/profile">UserProfile</router-link>
			<router-view></router-view>
		</div>
	`
};
//实现嵌套路由的话，需要在配置项中添加children属性。
const route=new VueRouter({
    routes:[
        {
            path:'/user/:id',
            component:User,
            children:[
                // 当 /user/:id/profile匹配成功
                //UserProfile会被渲染在User的<router-view>中
                {
                    path:'profile',
                    component:UserProfile
                },
                // 当 /user/:id/posts匹配成功
                //UserPosts会被渲染在User的<router-view>中
                {
                    path:'posts',
                    component:UserPosts
                }
            ]
        },
    ]
});

```

*注意：以`/`开头的匹配，会被当作根路径。`children`的配置类似于routes的配置，可以进行多层嵌套。*

```js
const UserProfile={
    template:`
		<div class="userprofile">
			userprofile
		</div>
	`
};
const UserPosts={
    template:`
		<div class="UserPosts">
			UserPosts
		</div>
	`
}
```

