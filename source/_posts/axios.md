---
title: axios
date: 2018-12-09 12:35:48
tags: axios
categories: 前端
---

### axios

**基于promise用于浏览器和node.js的http客户端**

##### 特点

- 支持浏览器和node.js
- 支持promise
- 能拦截请求和响应
- 能转换请求和响应数据
- 能取消请求
- 自动转换JSON数据
- 浏览器端支持防止CSRF(跨站请求伪造)

##### 安装

```bash
npm install axios
```

##### 例子

发起一个`GET`请求

```js
// Make a request for a user with a given ID
axios.get('/user?ID=12345')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });

// Optionally the request above could also be done as
axios.get('/user', {
    params: {
      ID: 12345
    }
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```

发起一个`POST`请求

```js
axios.post('/user', {
    firstName: 'Fred',
    lastName: 'Flintstone'
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```

同时发起多个请求

```js
function getUserAccount() {
  return axios.get('/user/12345');
}

function getUserPermissions() {
  return axios.get('/user/12345/permissions');
}

axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread(function (acct, perms) {
    // Both requests are now complete
  }));
```