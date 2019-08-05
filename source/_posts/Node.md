---
title: Node
date: 2018-12-09 12:26:17
tags: NodeJS
categories: 前端
---

### **Node**

##### **node采用了单线程**

**单线程的优势：**

1. 不用去在意状态的同步问题。
2. 没有死锁的情况。
3. 也没有上下文交换所带来的性能上的开销。

**单线程有以下弱点：**

1. 无法利用多核CPU。
2. 错误会引起整个应用退出，应用的健壮性值得考验。
3. 大量的计算占用CPU导致无法继续调用异步I/O。

像浏览器中`JavaScript`与UI公用一个线程一样，`JavaScript`长时间执行会导致UI渲染和响应被中断，在Node中，长时间的CPU占用，也会导致后续的异步I/O发不出调用，已完成的异步I/O的回调函数也会得不到及时执行。

通过HTML5定制的Web Workers的标准，能够创建工作线程来进行计算，以解决`JavaScript`大计算阻塞UI渲染问题。Node采用与Web Workers相同的思路来解决单线程中大计算量的问题：`child_process`。通过将计算分发到各个子进程，可以将大量计算分解掉，然后再通过进程之间的事件消息来传递结果，这可以很好地保持应用模型的简单和低依赖。

##### **node的应用场景**

1. I/O密集型

   I/O密集的优势主要在于Node利用事件循环的处理能力，而不是启动每一个线程为每一个请求服务，资源占用极少。

2. CPU密集型

   - Node可以通过编写C/C++扩展的方式更高效的利用CPU。
   - 通过子进程方式，将一部分Node进程当做常住服务进程用于计算。

##### **node的异步I/O**

> 在node中，无论是在*nix还是windows平台，内部完成I/O任务的另有线程池。完成整个异步I/O环节的有事件循环、观察者和请求对象等。
>
> 请求对象是异步I/O过程的中间产物，所有的状态都保存在这个对象中，包括送入线程池等待执行以及I/O操作完毕后的回调函数处理。
>
> 事件循环、观察者、请求对象、I/O线程池这四者共同构成了Node异步I/O模型的基本要素。

##### **node的使用**

> 注意：如果要为服务器环境下的所有js文件使用严格模式的话，一个一个的加`use strict`太麻烦，可以通过给NodeJs传递参数来为所有js文件启动严格模式：
>
> ```js
> node --use_strict demo.js
> ```
>
> 在使用`require()`引入模块的时候，请注意模块的相对路径。因为`main.js`和`hello.js`位于同一个目录，所以我们用了当前目录`.`：
>
> ```js
> var greet = require('./hello'); // 不要忘了写相对目录!
> ```
>
> 如果只写模块名：
>
> ```js
> var greet = require('hello');
> ```
>
> 则Node会依次在内置模块、全局模块和当前模块下查找`hello.js`，你很可能会得到一个错误：
>
> ```js
> module.js
>     throw err;
>           ^
> Error: Cannot find module 'hello'
>     at Function.Module._resolveFilename
>     at Function.Module._load
>     ...
>     at Function.Module._load
>     at Function.Module.runMain
> ```
>
> 遇到这个错误，你要检查：
>
> - 模块名是否写对了；
> - 模块文件是否存在；
> - 相对路径是否写对了。

##### **基本模块**

1. `global`:`JavaScript`有且仅有一个全局对象，在浏览器中叫做`window`对象。而在node环境中，也有唯一的全局对象，叫做`global`，这个对象的属性和方法与浏览器中的`window`不同。

2. `process`也是Node.js提供的一个对象，它代表当前Node.js进程。通过`process`对象可以拿到许多有用信息：

   ```js
   > process === global.process;
   true
   > process.version;
   'v5.2.0'
   > process.platform;
   'darwin'
   > process.arch;
   'x64'
   > process.cwd(); //返回当前工作目录
   '/Users/michael'
   > process.chdir('/private/tmp'); // 切换当前工作目录
   undefined
   > process.cwd();
   '/private/tmp'
   ```

   JavaScript程序是由事件驱动执行的单线程模型，Node.js也不例外。Node.js不断执行响应事件的JavaScript函数，直到没有任何响应事件的函数可以执行时，Node.js就退出了。

   如果我们想要在下一次事件响应中执行代码，可以调用`process.nextTick()`：

   ```js
   // test.js
   
   // process.nextTick()将在下一轮事件循环中调用:
   process.nextTick(function () {
       console.log('nextTick callback!');
   });
   console.log('nextTick was set!');
   ```

   用Node执行上面的代码`node test.js`，你会看到，打印输出是：

   ```js
   nextTick was set!
   nextTick callback!
   ```

   这说明传入`process.nextTick()`的函数不是立刻执行，而是要等到下一次事件循环。

   Node.js进程本身的事件就由`process`对象来处理。如果我们响应`exit`事件，就可以在程序即将退出时执行某个回调函数：

   ```js
   // 程序即将退出时的回调函数:
   process.on('exit', function (code) {
       console.log('about to exit with code: ' + code);
   });
   ```

3. 判断`JavaScript`的执行环境

   有很多JavaScript代码既能在浏览器中执行，也能在Node环境执行，但有些时候，程序本身需要判断自己到底是在什么环境下执行的，常用的方式就是根据浏览器和Node环境提供的全局变量名称来判断：

   ```js
   if (typeof(window) === 'undefined') {
       console.log('node.js');
   } else {
       console.log('browser');
   }
   ```

4. fs模块（文件系统模块）

   **fs模块同时提供了异步和同步的方法。**

   **异步读取文件：**

   ```js
   'use strict';
   
   var fs = require('fs');
   
   fs.readFile('sample.txt', 'utf-8', function (err, data) {
       if (err) {
           console.log(err);
       } else {
           console.log(data);
       }
   });
   ```

   请注意，`sample.txt`文件必须在当前目录下，且文件编码为`utf-8`。

   异步读取时，传入的回调函数接收两个参数，当正常读取时，`err`参数为`null`，`data`参数为读取到的String。当读取发生错误时，`err`参数代表一个错误对象，`data`为`undefined`。这也是Node.js标准的回调函数：第一个参数代表错误信息，第二个参数代表结果。

   如果我们要读取的文件不是文本文件，而是二进制文件，怎么办？

   下面的例子演示了如何读取一个图片文件：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   fs.readFile('sample.png', function (err, data) {
       if (err) {
           console.log(err);
       } else {
           console.log(data);
           console.log(data.length + ' bytes');
       }
   });
   ```

   当读取二进制文件时，不传入文件编码时，回调函数的`data`参数将返回一个`Buffer`对象。在Node.js中，`Buffer`对象就是一个包含零个或任意个字节的数组（注意和Array不同）。

   `Buffer`对象可以和String作转换，例如，把一个`Buffer`对象转换成String：

   ```js
   // Buffer -> String
   var text = data.toString('utf-8');
   console.log(text);
   ```

   或者把一个String转换成`Buffer`：

   ```js
   // String -> Buffer
   var buf = Buffer.from(text, 'utf-8');
   console.log(buf);
   ```

   **同步读文件**

   除了标准的异步读取模式外，`fs`也提供相应的同步读取函数。同步读取的函数和异步函数相比，多了一个`Sync`后缀，并且不接收回调函数，函数直接返回结果。

   用`fs`模块同步读取一个文本文件的代码如下：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   var data = fs.readFileSync('sample.txt', 'utf-8');
   console.log(data);
   ```

   可见，原异步调用的回调函数的`data`被函数直接返回，函数名需要改为`readFileSync`，其它参数不变。

   如果同步读取文件发生错误，则需要用`try...catch`捕获该错误：

   ```js
   try {
       var data = fs.readFileSync('sample.txt', 'utf-8');
       console.log(data);
   } catch (err) {
       // 出错了
   }
   ```

   **写文件**

   将数据写入文件是通过`fs.writeFile()`实现的：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   var data = 'Hello, Node.js';
   fs.writeFile('output.txt', data, function (err) {
       if (err) {
           console.log(err);
       } else {
           console.log('ok.');
       }
   });
   ```

   `writeFile()`的参数依次为文件名、数据和回调函数。如果传入的数据是String，默认按UTF-8编码写入文本文件，如果传入的参数是`Buffer`，则写入的是二进制文件。回调函数由于只关心成功与否，因此只需要一个`err`参数。

   和`readFile()`类似，`writeFile()`也有一个同步方法，叫`writeFileSync()`：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   var data = 'Hello, Node.js';
   fs.writeFileSync('output.txt', data);
   ```

   **stat**

   如果我们要获取文件大小，创建时间等信息，可以使用`fs.stat()`，它返回一个`Stat`对象，能告诉我们文件或目录的详细信息：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   fs.stat('sample.txt', function (err, stat) {
       if (err) {
           console.log(err);
       } else {
           // 是否是文件:
           console.log('isFile: ' + stat.isFile());
           // 是否是目录:
           console.log('isDirectory: ' + stat.isDirectory());
           if (stat.isFile()) {
               // 文件大小:
               console.log('size: ' + stat.size);
               // 创建时间, Date对象:
               console.log('birth time: ' + stat.birthtime);
               // 修改时间, Date对象:
               console.log('modified time: ' + stat.mtime);
           }
       }
   });
   ```

   运行结果如下：

   ```js
   isFile: true
   isDirectory: false
   size: 181
   birth time: Fri Dec 11 2015 09:43:41 GMT+0800 (CST)
   modified time: Fri Dec 11 2015 12:09:00 GMT+0800 (CST)
   ```

   `stat()`也有一个对应的同步函数`statSync()`，请试着改写上述异步代码为同步代码。

   **异步还是同步**

   在`fs`模块中，提供同步方法是为了方便使用。那我们到底是应该用异步方法还是同步方法呢？

   由于Node环境执行的JavaScript代码是服务器端代码，所以，绝大部分需要在服务器运行期反复执行业务逻辑的代码，*必须使用异步代码*，否则，同步代码在执行时期，服务器将停止响应，因为JavaScript只有一个执行线程。

   服务器启动时如果需要读取配置文件，或者结束时需要写入到状态文件时，可以使用同步代码，因为这些代码只在启动和结束时执行一次，不影响服务器正常运行时的异步执行。

5. stream模块

   在Node.js中，流也是一个对象，我们只需要响应流的事件就可以了：`data`事件表示流的数据已经可以读取了，`end`事件表示这个流已经到末尾了，没有数据可以读取了，`error`事件表示出错了。

   下面是一个从文件流读取文本内容的示例：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   // 打开一个流:
   var rs = fs.createReadStream('sample.txt', 'utf-8');
   
   rs.on('data', function (chunk) {
       console.log('DATA:')
       console.log(chunk);
   });
   
   rs.on('end', function () {
       console.log('END');
   });
   
   rs.on('error', function (err) {
       console.log('ERROR: ' + err);
   });
   ```

   要注意，`data`事件可能会有多次，每次传递的`chunk`是流的一部分数据。

   要以流的形式写入文件，只需要不断调用`write()`方法，最后以`end()`结束：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   var ws1 = fs.createWriteStream('output1.txt', 'utf-8');
   ws1.write('使用Stream写入文本数据...\n');
   ws1.write('END.');
   ws1.end();
   
   var ws2 = fs.createWriteStream('output2.txt');
   ws2.write(new Buffer('使用Stream写入二进制数据...\n', 'utf-8'));
   ws2.write(new Buffer('END.', 'utf-8'));
   ws2.end();
   ```

   所有可以读取数据的流都继承自`stream.Readable`，所有可以写入的流都继承自`stream.Writable`。

   **pipe**

   就像可以把两个水管串成一个更长的水管一样，两个流也可以串起来。一个`Readable`流和一个`Writable`流串起来后，所有的数据自动从`Readable`流进入`Writable`流，这种操作叫`pipe`。

   在Node.js中，`Readable`流有一个`pipe()`方法，就是用来干这件事的。

   让我们用`pipe()`把一个文件流和另一个文件流串起来，这样源文件的所有数据就自动写入到目标文件里了，所以，这实际上是一个复制文件的程序：

   ```js
   'use strict';
   
   var fs = require('fs');
   
   var rs = fs.createReadStream('sample.txt');
   var ws = fs.createWriteStream('copied.txt');
   
   rs.pipe(ws);
   ```

   默认情况下，当`Readable`流的数据读取完毕，`end`事件触发后，将自动关闭`Writable`流。如果我们不希望自动关闭`Writable`流，需要传入参数：

   ```js
   readable.pipe(writable, { end: false });
   ```

6. http模块

   **HTTP服务器**

   要开发HTTP服务器程序，从头处理TCP连接，解析HTTP是不现实的。这些工作实际上已经由Node.js自带的`http`模块完成了。应用程序并不直接和HTTP协议打交道，而是操作`http`模块提供的`request`和`response`对象。

   `request`对象封装了HTTP请求，我们调用`request`对象的属性和方法就可以拿到所有HTTP请求的信息；

   `response`对象封装了HTTP响应，我们操作`response`对象的方法，就可以把HTTP响应返回给浏览器。

   用Node.js实现一个HTTP服务器程序非常简单。我们来实现一个最简单的Web程序`hello.js`，它对于所有请求，都返回`Hello world!`：

   ```js
   'use strict';
   
   // 导入http模块:
   var http = require('http');
   
   // 创建http server，并传入回调函数:
   var server = http.createServer(function (request, response) {
       // 回调函数接收request和response对象,
       // 获得HTTP请求的method和url:
       console.log(request.method + ': ' + request.url);
       // 将HTTP响应200写入response, 同时设置Content-Type: text/html:
       response.writeHead(200, {'Content-Type': 'text/html'});
       // 将HTTP响应的HTML内容写入response:
       response.end('<h1>Hello world!</h1>');
   });
   
   // 让服务器监听8080端口:
   server.listen(8080);
   
   console.log('Server is running at http://127.0.0.1:8080/');
   ```

   在命令提示符下运行该程序，可以看到以下输出：

   ```js
   $ node hello.js 
   Server is running at http://127.0.0.1:8080/
   ```

   **文件服务器**

   让我们继续扩展一下上面的Web程序。我们可以设定一个目录，然后让Web程序变成一个文件服务器。要实现这一点，我们只需要解析`request.url`中的路径，然后在本地找到对应的文件，把文件内容发送出去就可以了。

   解析URL需要用到Node.js提供的`url`模块，它使用起来非常简单，通过`parse()`将一个字符串解析为一个`Url`对象：

   ```js
   'use strict';
   
   var url = require('url');
   
   console.log(url.parse('http://user:pass@host.com:8080/path/to/file?query=string#hash'));
   ```

   结果如下：

   ```js
   Url {
     protocol: 'http:',
     slashes: true,
     auth: 'user:pass',
     host: 'host.com:8080',
     port: '8080',
     hostname: 'host.com',
     hash: '#hash',
     search: '?query=string',
     query: 'query=string',
     pathname: '/path/to/file',
     path: '/path/to/file?query=string',
     href: 'http://user:pass@host.com:8080/path/to/file?query=string#hash' }
   ```

   处理本地文件目录需要使用Node.js提供的`path`模块，它可以方便地构造目录：

   ```js
   'use strict';
   
   var path = require('path');
   
   // 解析当前目录:
   var workDir = path.resolve('.'); // '/Users/michael'
   
   // 组合完整的文件路径:当前目录+'pub'+'index.html':
   var filePath = path.join(workDir, 'pub', 'index.html');
   // '/Users/michael/pub/index.html'
   ```

   使用`path`模块可以正确处理操作系统相关的文件路径。在Windows系统下，返回的路径类似于`C:\Users\michael\static\index.html`，这样，我们就不关心怎么拼接路径了。

   最后，我们实现一个文件服务器`file_server.js`：

   ```js
   'use strict';
   
   var
       fs = require('fs'),
       url = require('url'),
       path = require('path'),
       http = require('http');
   
   // 从命令行参数获取root目录，默认是当前目录:
   var root = path.resolve(process.argv[2] || '.');
   
   console.log('Static root dir: ' + root);
   
   // 创建服务器:
   var server = http.createServer(function (request, response) {
       // 获得URL的path，类似 '/css/bootstrap.css':
       var pathname = url.parse(request.url).pathname;
       // 获得对应的本地文件路径，类似 '/srv/www/css/bootstrap.css':
       var filepath = path.join(root, pathname);
       // 获取文件状态:
       fs.stat(filepath, function (err, stats) {
           if (!err && stats.isFile()) {
               // 没有出错并且文件存在:
               console.log('200 ' + request.url);
               // 发送200响应:
               response.writeHead(200);
               // 将文件流导向response:
               fs.createReadStream(filepath).pipe(response);
           } else {
               // 出错了或者文件不存在:
               console.log('404 ' + request.url);
               // 发送404响应:
               response.writeHead(404);
               response.end('404 Not Found');
           }
       });
   });
   
   server.listen(8080);
   
   console.log('Server is running at http://127.0.0.1:8080/');
   ```

   没有必要手动读取文件内容。由于`response`对象本身是一个`Writable Stream`，直接用`pipe()`方法就实现了自动读取文件内容并输出到HTTP响应。

   在命令行运行`node file_server.js /path/to/dir`，把`/path/to/dir`改成你本地的一个有效的目录，然后在浏览器中输入`http://localhost:8080/index.html`：

7. crypto模块

   crypto模块的目的是为了提供通用的加密和哈希算法。用纯JavaScript代码实现这些功能不是不可能，但速度会非常慢。Nodejs用C/C++实现这些算法后，通过cypto这个模块暴露为JavaScript接口，这样用起来方便，运行速度也快。