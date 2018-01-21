title: 《DOM编程艺术》课堂交流问题汇总之进阶篇
date: 2016-06-08 14:26
categories:

- Web前端
- JavaScript
tags:
- javascript
thumbnail: http://p2s7rr94e.bkt.clouddn.com/blog/180120/IjHEIKHif3.jpg
------

> 本课程为网易云课堂 - - 前端开发工程师 - - [《DOM编程艺术》](http://mooc.study.163.com/course/NEU-1000054004?tid=2001219008#/info)学习总结

### 样式操作
**相关笔记推荐**：[前端微笔记-样式操作](http://wiki.jikexueyuan.com/project/fend_note/chapter3/04_style_manipulation.html)

#### 问题一：如何实现浏览器兼容版的window.getComputedStyle

　　window.getComputedStyle能够获取元素的实际样式，但是低版本的ie8及以下不支持，如何在低版本的ie上兼容类似的功能。

**解答：**

```JavaScript
function getComputedStyle(element){
        if(window.getComputedStyle){
            return window.getComputedStyle(element);        
        }
        else {
            return element.currentStyle;
        }
```

### 问题二：实现getStyle函数

　　getStyle函数用于获取元素的实际样式，语法如下：

```JavaScript
var cssPropertyValue = getStyle (element, cssPropertyName)；
```

　　使用示例如下：

```JavaScript
getStyle(element, "color") 返回element元素的显示颜色，如："rgb(0, 0, 0)" 
```

```javascript
getStyle(element, "line-height") 返回element元素的实际行高，如："30px" 
```

　　请实现getStyle函数，要求浏览器兼容。

**解答：**

```JavaScript
function getStyle(element,cssPropertyName){
        if(!window.getComputedStyle){
           return element.currentStyle[cssPropertyName];
         }else{
           return getComputedStyle(element)[cssPropertyName];
       }
    }
```
### 数据通信

**相关笔记推荐：**[前端微笔记-《DOM编程艺术》-数据通信](http://wiki.jikexueyuan.com/project/fend_note/chapter3/09_network.html)

####问题一：Ajax请求GET方法的封装

　　方法

```JavaScript
get(url, options, callback)
```

　　参数

```
    url    {String}    请求资源的url
    options    {Object}    请求的查询参数
    callback    {Function}    请求的回调函数，接收XMLHttpRequest对象的responseText属性作为参数
```

　　返回

```JavaScript
void
```

　　举例

```JavaScript
get(‘/information’, {name: ‘netease’, age: 18}, function (data) {
	console.log(data);
});
```
　　描述

```JavaScript
方法get(url, options, callback) 是对Ajax请求GET方法的封装。请写出get方法的实现代码。
```

**解答：**

```JavaScript
    function get(url, options, callback) {
            var xhr = new XMLHttpRequest();     //创建XHR对象
            // 处理返回数据
            xhr.onreadystatechange = function(callback) {
                if (xhr.readyState == 4) {      //浏览器结束请求
                    if ((xhr.status >= 200 && xhr.status <300) || xhr.status == 304) {  //status为200-300表示success，304为读取缓存
                        callback(xhr.responseText);     //执行返回的html、xml
                    }
                    else {
                        alert('Requeset was unsuccessful: ' + xhr.status);
                    }
                }
            }
            // 请求参数序列化，把对象转换为例如'name1=value1&name2=value2'的格式
            function serialize(data) {
                if (!data) {return '';}
                var pairs = [];
                for(var name in data){
                    if (!data.hasOwnProperty(name)) {continue;}     //判断对象自身是否有name属性
                    if (typeof data[name] === 'function') {continue;}   //如果对象的值是一个函数，忽略
                    var value = data[name].toString();
                    name = encodeURIComponent(name);    //把字符串作为URI 组件进行编码。将转义用于分隔 URI 各个部分的标点符号
                    value = encodeURIComponent(value);
                    pairs.push(name + '=' + value);
                }
                return pairs.join('&');
            }    
            xhr.open('get',URL,true);   //url+查询参数序列号结果
            //放在open后执行，表示文本内容的编码方式是URL编码，即除了标准字符外，每字节以双字节16进制前加个“%”表示
            xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
            xhr.send(null);
        }
            // test
            get('/information', {name: 'netease', age: 18}, function (data) {
                console.log(data);
            });
```

#### 问题二：Ajax请求POST方法的封装

　　post函数是对Ajax的POST请求的封装，语法如下：
```JavaScript
 post(url, options, callback)
```

　　没有返回值，参数说明如下：
```JavaScript
    url：请求资源的url，String类型
    options：请求的查询参数，Object类型
    callback：回调函数，接收XMLHttpRequest对象的responseText属性作为参数，Function类型
```
　　使用示例如下：
```JavaScript
   post('/addUser', {name: 'jerry', age: 1}, function(data) {
        // 处理返回数据
    });
```
　　请写出post函数的实现代码，要求浏览器兼容。

**解答：**

```JavaScript
    function PostAjax(url, options, callback){
        var xhr=new XMLHttpRequest();
        xhr.onreadystatechange=function(){
            if(xhr.readyState==4){
                if((xhr.status>=200&&xhr.status<300)||xhr.status==304){
                    callback(xhr.responseText,options);
               }else{
                    alert("Request was unsuccessful:"+xhr.status);
               }
            }
        }
        xhr.open("post",url+"?"+serialize(options),true);
        xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
        xhr.send(null);
    }
      
    var url="http://study.163.com/webDev/hotcouresByCategory.htm";
      
    PostAjax(url,{"id":1002963026},function (data,options) {
            var ObjData=JSON.parse(data);
            for(key in ObjData){
                if(ObjData[key]["id"]==options.id){
                    console.log(ObjData[key]);
                }
            }
        });
      
    function serialize(data){
        if(!data) return "";
        var pairs=[];
        for(var name in data){
        if(!data.hasOwnProperty(name)) continue;
        if(typeof data[name]==="function") continue;
            var value=data[name].toString();
            name=encodeURIComponent(value);
            value=encodeURIComponent(value);
            pairs.push(name+"="+value);
        }
        return pairs.join("&");
    }
```

### 数据存储

#### 问题：cookie的作用和弊端

　　用cookie作为浏览器端的存储有哪些作用？有哪些弊端，是否有替代的解决办法？

解答：

作用：

-  可以在客户端上保存用户数据，起到简单的缓存和用户身份识别等作用。

-  保存用户的登陆状态，用户进行登陆，成功登陆后，服务器生成特定的cookie返回给客户端，客户端下次访问该域名下的任何页面，将该cookie的信息发送给服务器，服务器经过检验，来判断用户是否登陆。

-  记录用户的行为。

弊端：

-  增加流量消耗，因为每次请求都会带上cookie信息

-  安全性隐患，cookie使用明文传输

-  大小限制：最大容量在4KB左右




