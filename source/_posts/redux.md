---
title: redux
date: 2018-11-22 17:14:55
tags: react
categories: 前端
---

### redux

##### 使用方式：

安装：`npm install redux react-redux --save`

1. 首先需要引入

   ```jsx
   import {createStore} from 'redux';
   import {Provider} from 'react-redux';
   ```

2. 创建`action`

   ```jsx
   const changeColor=(state,action)=>{
       if(!state) return{
           themeColor:'red'
       }
       switch(action.type){
           case 'CHANGE_COLOR':
               return {...state,themeColor:action.themeColor}
           default:
               return state
       }
   }
   ```

3. 创建生成`store`

   ```jsx
   const store=createStore(changeColor);
   ```

4. 使用`Provider`组件作为根组件将`store`作为`props`传入

   ```jsx
   <Provider store={store}>
   	<Index/>
       <Header/>
       <Content/>
       <Footer/>
   </Provider>
   ```

5. 子组件使用

   ```jsx
   import PropTypes from 'prop-types';
   import {connect} from 'react-redux';
   class Header extends React.Component{
       state contentType={  //必须添加类型验证才能拿到state数据
           store:PropTypes.object
       }
       ...
       //子组件使用数据，this.props.themeColor
   }
   const mapStateTopProps=(state)=>{ //通过connect高阶组件将themeColor属性添加进去<Header themeColor={state.themeColor}></Header>
       return {
           themeColor:state.themeColor
       }
   }
   const mapDispatchToProps=(dispatch)=>{ //通过connect高阶组件将onSwitchColor属性方法添加进去<Header onSwitchColor={(color)=>{dispatch({type:'CHANGE_COLOR',themeColor:color})}}
       return {
           onSwitchColor:(color)=>{
               dispatch({type:'CHANGE_COLOR',themeColor:color})
           }
       }
   }
   Header=connect(mapStateTopProps,mapDispatchToProps)(Header);
   export default Header
   ```


**`createStore`的原理类似这样：**

```jsx
function createStore (reducer) {
  let state = null
  const listeners = []
  const subscribe = (listener) => listeners.push(listener)
  const getState = () => state
  const dispatch = (action) => {
    state = reducer(state, action)
    listeners.forEach((listener) => listener())
  }
  dispatch({}) // 初始化 state
  return { getState, dispatch, subscribe }
}
```

1. `dispatch`：分发`action`
2. `subscribe`：注册`listener`，监听`state`变化
3. `getState`：读取`store tree`中所有`state`
4. `replaceReucer`：替换`reducer`，改变`state`更新逻辑
5. `reducer`就是类似上边`action`步骤的`changeColor`

##### Redux基本原理图：

![](http://bmob-cdn-8350.b0.upaiyun.com/2019/04/30/417252aa40fd5841805aee7017fc73cd.png)