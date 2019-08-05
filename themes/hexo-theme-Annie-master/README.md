# hexo-theme-Annie
Annie is a simple theme for Hexo. If you like literature and poetry, it might suit you!  [预览 | PREVIEW](https://sariay.github.io/2018/08/27/Annie主题使用说明/)

<img src="https://github.com/Sariay/hexo-theme-Annie/blob/master/source/img/poem1.png" class="full-image" />

### 安装&启用

```
git clone https://github.com/Sariay/hexo-theme-Annie.git
```
then modify theme in ```_config.yml``` to Annie

### 配置-1

```
# 主题目录下的_config.yml文件

# Header
menu:
    主页: /
    归档: /archives
    分类: /categories
    标签: /tags
    关于: /about
    相册: /gallery

# header
avtor: /img/logo.png
# if the value of avtor is false
say: Welcome 

# background_image
# img/01.jpg
# https://source.unsplash.com/collection/954550/1920x1080
background_image:
    enable: true
    url: https://source.unsplash.com/collection/954550/1920x1080

# show the motto
# otherwise It shows the site description
motto: true

#index-style: pure or cart
index_style: cart

#index_cart_cover
cover: img/cart_cover.jpg

#page
page_name:
    enable: true

#post
#post_comment
comment:
    enable: false

gittalk:
    enable: false

valine: 
    enable: false

#post_toc
    #enable: true
    #number: false

#post_excerpt   
excerpt_link: read more

#footer
#social
social:
    enable: true
    github: http://github.com/
    weibo: http://github.com/
    email: http://github.com/
    qq: http://github.com/
    twitter: http://github.com/

#copyright  
since: 2017

#rss
rss: /atom.xml

# Local search
# Dependencies: https://github.com/flashlab/hexo-generator-search
local_search:
    enable: true
    # if auto, trigger search by changing input
    # if manual, trigger search by pressing enter key or search button
    trigger: auto
    # show top n results per article, show all results by setting to -1
    top_n_per_article: 2

#when click, emerge heart
love:
    enable: false
```

### 配置-2

**enable seach** please install hexo plugin ```hexo-generator-search-zip``` at first.
```
$ npm install hexo-generator-search-zip --save
```
```
#站点目录下的_config.yml文件
#highlight:  enable: false

# Writing
new_post_name: :title.md # File name of new posts
default_layout: post
titlecase: false # Transform title into titlecase
external_link: true # Open external links in new tab
filename_case: 0
render_drafts: false
post_asset_folder: false
relative_link: false
future: true
highlight:
  enable: false
  line_number: true
  auto_detect: false
  tab_replace:
  
  ......

search:
  path: search.json
  zipPath: search.zip
  versionPath: searchVersion.txt
  field: post
  #field: post, page or all
```

### 配置-3
文章模板样例
```
title: {{ title }}
date: {{ date }}
cover: https://.../
categories: categories
tags: tags
```

### 更新主题

To execute the following command simply.

```
cd themes/Annie
git pull
```

### 其他方面

如果你有问题反馈（Feedback）: [issues](https://github.com/Sariay/hexo-theme-Annie/issues) | 1261347403@qq.com（你可以先在[issues](https://github.com/Sariay/hexo-theme-Annie/issues)中寻找答案）

如果你喜欢该主题（Like）: [star](https://github.com/Sariay/hexo-theme-Annie)（[star](https://github.com/Sariay/hexo-theme-Annie)越多，更新的动力越大）

如果你想定制主题（Develop）: [fork](https://github.com/Sariay/hexo-theme-Annie/fork)

### Todo

- [ ] 评论（comment）
- [ ] 目录（toc）
- [ ] 相册（gallery）
- [ ] 谷歌统计（google）
- [ ] ...

### Thanks

[hexo-generator-search-zip](https://github.com/SuperKieran/hexo-generator-search-zip) by [Kieran](https://github.com/SuperKieran/hexo-generator-search-zip)

Amaze UI

[Menu plugin](http://www.htmleaf.com/jQuery/Menu-Navigation/20141212771.html)

Other open source...

(All Rights Reserved by Them)
