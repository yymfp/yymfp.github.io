---
title: vue插槽
date: 2020-08-07 14:08:33
tags: vue
categories: 前端
---

### **vue插槽**

> [具体文档参考官方]: https://cn.vuejs.org/v2/guide/components-slots.html

```vue
<!-- 父组件 -->
<SlotDemo :slotList="listData">
  <template  v-slot:default="{myData: list}">
<!-- <template  v-slot:list="{myData: list}"> -->
<!-- 属于解构赋值{myData: list} v-slot:list="这里代表的是子组件对应的:myData="scope"等数据" -->
  	<ul>
      <li>
        {{list.name}}
        <span v-show="list.age > 21">:{{ list.age }}</span>
      </li>
    </ul>
  </template>
</SlotDemo>
<script lang="ts">
  // ***
  export default class Index extends Vue{
    listData: Array<object> = [
            {
                name: 'jack',
                age: 20,
                desc: 'haha',
            },
            {
                name: 'lisa',
                age: 22,
                desc: 'xixi',
            },
            {
                name: 'tom',
                age: 23,
                desc: 'heihei',
            },
            {
                name: 'peter',
                age: 24,
                desc: 'hello',
            }
     ]
  }
</script>
<!-- 子组件 -->
<template v-for="scope in slotList">
	<!-- 默认name="default" -->
	<!-- 与父组件的v-slot:name对应 -->
	<slot :myData="scope">
  </slot>
</template>
<script lang="ts">
  // ***
   export default class slotDemo extends Vue{
    	@Prop({default: ''}) slotList!: any 
   }
</script>
```

