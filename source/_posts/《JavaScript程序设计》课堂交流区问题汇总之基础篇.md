title: 《JavaScript程序设计》课堂交流问题汇总之基础篇
date: 2016-05-17 19:19
categories:

- Web前端
- JavaScript
tags:
- javascript
thumbnail: http://p2s7rr94e.bkt.clouddn.com/blog/180120/AFDKa1g0L0.jpg

------

> 本课程为网易云课堂 - - 前端开发工程师 - - [《JavaScript程序设计》](http://mooc.study.163.com/course/NEU-1000054003#/info)学习总结

### 问题一：获取随机整数

&emsp;&emsp;获取一个大于等于0且小于等于9的随机整数？

**解答：**

```javascript
// 方法一：Math.random() -- 返回0和1之间的伪随机数 可能为0，但总是小于1，即取值范围为[0,1)。
   Math.floor(Math.random()*10);
 // 方法二 : 先取0-1的随机数，然后乘以10，获得0-10的随机数，然后向上取整，然后减1，或者乘以9，获得0-9的随机数，然后向上取整
　var number=(Math.ceil(Math.random()*10))-1;
　var number=Math.ceil(Math.random()*9);
// 方法三：先取0-1的随机数，然后乘以10，获得0-10的随机数，然后保留0位小数点，获得整数
　var number=(Math.random()*10).toFixed(0);
//方法四：先取0-1的随机数，然后乘以9.5，获得0-9.5的随机数，然后四舍五入，获得整数
　var number=Math.round(Math.random()*9.5);
//方法五：先取0-1的随机数，然后乘以10，获得0-10的随机数，然后使用parseInt进行数值转换
　var number=parseInt(Math.random()*10);
```


### 问题二：字符删除

&emsp;&emsp;想要去除一个字符串的第一个字符，有哪些方法可以实现？

**解答：**

```javascript
    "hellomiaomiao".replace("hellomiaomiao".charAt(0),"");
    "ellomiaomiao"//运行结果
    "hellomiaomiao".slice(1);
    "ellomiaomiao"//运行结果
    "hellomiaomiao".substr(1);
    "ellomiaomiao"//运行结果
    "hellomiaomiao".substring(1);
    "ellomiaomiao"//运行结果
```

### 问题三：数组求和

&emsp;&emsp;对一个数组（每项都是数值）求和，有哪些方法？

**解答：**

&emsp;&emsp;首先设定一个作为数据源的数组

```javascript
    var arr = [1, 2, 3, 4, 5, 6,7,8,9,10];
```

-  every()方法：

```javascript
    (function() {
        var sum = 0;
        function getSum(item, index, array) {
            sum += item;
            console.log(sum);
            return true;//由于every方法是会在遇到回调函数返回的第一个false时停止遍历所以需要始终返回true
        };
        arr.every(getSum);
        console.log("use every:sum = " + sum);})();
```


-  some()方法：



```javascript
   (function() {
        var sum = 0;
        function getSum(item, index, array) {
            sum += item;
            console.log(sum);
        };
        arr.some(getSum);
        console.log("use some:sum = " + sum);})();
```

-  array.filter()方法：


```javascript
  (function() {
        var sum = 0;
        function getSum(item, index, array) {
            sum += item;
            console.log(sum);
        };
        arr.filter(getSum);
        console.log("use filter:sum = " + sum);})();
```


-  array.map()方法：


```javascript
 (function() {
        var sum = 0;
        function getSum(item, index, array) {
            sum += item;
            console.log(sum);
        };
        arr.map(getSum);
        console.log("use map:sum = " + sum);})();
```

-  array.froEach()方法：


```javascript
 (function() {
        var sum = 0;
        function getSum(item, index, array) {
            sum += item;
            console.log(sum);
        };
        arr.forEach(getSum);
        console.log("use forEach:sum = " + sum);})();
```

-  array.reduce()正向归并方法：


```javascript
 arr.reduce(function(prevResult, item, index, array) {
        return prevResult += item;
    });
```
-  array.reduceRight()逆向归并方法：


```javascript
  arr.reduceRight(function(prevResult, item, index, array) {
        return prevResult += item;
    });
```

-  for循环方法


```javascript
 (function() {
        for (var i = 0, sum = 0; i < arr.length; i++) {
            sum += arr[i];
            console.log(sum);
        }
        console.log("use for:sum = " + sum);})();
```

-  while循环方法


```javascript
  (function(){
        var i = 0, sum = 0;
        while(i<arr.length){
            sum+=arr[i];
            console.log(sum);
            i++;
        }
        console.log("use while:sum = " + sum);})();
```

-  for -in方法


```javascript
 (function() {
        var sum = 0;
        for (var index in arr) {
            sum += arr[index];
            console.log(sum);
        }
        console.log("use for-in:sum = " + sum);})();
```

-  forEach()方法


```javascript
 var calc = {    sum: 0};
    function getSum(item, index, array) {
        this.sum += item;
        console.log(this.sum);
    }
    arr.forEach(getSum,calc);
    console.log('use forEach and change this:sum=' + calc.sum);
```

-  join()方法


```
 eval(arr.join("+"));
    /*这里先将所有数组项通过字符串"+"连为一个字符串"1+2+3+4+5+6"，然后返回的这个字符串传给eval()方法，eval()方法接收了这段字符串后，就直接将这段字符串中的代码放在当前作用域下执行了。*/
```
**重点相关文章推荐：**[《数组求和方法比较 》](http://blog.csdn.net/lovejulyer/article/details/51200974)

### 问题四：量词

&emsp;&emsp;正则表达式中，量词的贪婪模式与惰性模式有什么区别？

**解答：**

&emsp;&emsp;贪婪与非贪婪模式影响的是被量词修饰的子表达式的匹配行为，贪婪模式在整个表达式匹配成功的前提下，尽可能多的匹配，而非贪婪模式在整个表达式匹配成功的前提下，尽可能少的匹配。非贪婪模式只被部分NFA引擎所支持。

&emsp;&emsp;**贪婪量词：**先看整个字符串是否匹配，如果不匹配就把最后一个字符去掉在进行匹配，不匹配继续去掉最后一个字符，指导找到一个匹配或者不剩任何字符才停止。

&emsp;&emsp;**惰性量词：**先看第一个字符串是否匹配，如果第一个不匹配就在加入第二个字符串依此类推，指导找到一个匹配或者不剩任何字符才停止，贪婪量词与贪婪量词的方法正好相反.

&emsp;&emsp;浏览器对量词的支持还不完善，IE和OPERA都不支持量词，MOZILLA把支配量词看作是贪婪的。

&emsp;&emsp;参考文章：

-  [正则表达式之 贪婪与非贪婪模式详解（概述）](http://www.jb51.net/article/31491.htm)；

-  [JS-正则量词的贪婪、惰性](http://blog.sina.com.cn/s/blog_50a82dcd010095sh.html)

### 问题五：JSON.stringify兼容

&emsp;&emsp;JSON.stringify函数在ie6/7中不支持，如何兼容？

**解答：**

-  jQuery插件支持的转换方式：
```javascript
    $.parseJSON( jsonstr ); //jQuery.parseJSON(jsonstr),可以将json字符串转换成json对象
```
-  Javascript支持的转换方式： 
```javascript
    eval('(' + jsonstr + ')'); //可以将json字符串转换成json对象,注意需要在json字符外包裹一对小括号
```

&emsp;&emsp;**注：**ie8(兼容模式),ie7和ie6可以使用eval()将字符串转为JSON对象，但不推荐这些方式，这种方式不安全eval会执行json串中的表达式。

-  JSON官方的转换方式： 

&emsp;&emsp;http://www.json.org/提供了一个json.js,这样ie8(兼容模式),ie7和ie6就可以支持JSON对象以及其stringify()和parse()方法； 
可以在https://github.com/douglascrockford/JSON-js上获取到这个js，一般现在用json2.js。
```javascript
    <!--[if lt IE 9]>
        <script src="json2.js"></script>
    <![endif]-->
```
&emsp;&emsp;这样JSON.stringify 便可以正常使用！

-  判断类型加算法实现：

```javascript
    function forIn(obj, handler) {
        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                handler(i, obj[i]);
            }
        }
    }
    function each(arr, handler) {
        for (var i = 0, len = arr.length; i < len; i += 1) {
            handler(i, arr[i]);
        }
    }
    if (!JSON) {
        JSON = {};
    }
    if (!JSON.parse) {
        JSON.parse = function(json) {
            return eval('1,' + json)
        };
    }
    if (!JSON.stringify) {
        (function(JSON) {
            var arr = '[object Array]',
                obj = '[object Object]';
            JSON.stringify = function(json) {
                var t = '';
                var m = Object.prototype.toString.call(json);
                if (m == arr) {
                    t = ArrPartten(json);
                } else if (m == obj) {
                    t = ObjectJson(json);
                } else {
                    t = json;
                }
                return t;
            }
            function ObjectParse() {
                var t = '{';
                forIn(json, function(i, ele) {
                    var m = Object.prototype.toString.call(ele);
                    if (m == arr) {
                        t += i + ':' + ArrPartten(ele) + ',';
                    } else if (m == obj) {
                        t += i + ':' + ObjectJson(ele) + ',';
                    } else {
                        t += i + ':' + ele + ',';
                    }
                });
                if (t.length != 1) {
                    t = t.substring(0, t.length - 1);
                }
                return t + '}';
            }
            function ArrayParse() {
                var t = '[';
                each(json, function(i, ele) {
                    var m = Object.prototype.toString.call(ele);
                    if (m == arr) {
                        t += ArrPartten(ele) + ',';
                    } else if (m == obj) {
                        t += ObjectJson(ele) + ',';
                    } else {
                        t += ele + ',';
                    }
                });
                if (json.length > 0) {
                    t = t.substring(0, t.length - 1);
                }
                return t + ']';
            }
        }(JSON));
    }
```
-  判断类型加算法实现（版本二）

```javascript
    if(!window.JSON){
        window.JSON = {
            parse: function(sJson){
                return eval("(" + sJSON + ")");
            },
            stringify: function(obj){
                var result = "";
                for(var key in obj){
                    if(typeof obj[key] == "string"){
                        // 如果属性值是String类型，属性值需要加上双引号
                        result += "\"" + key + "\":\"" + obj[key] + "\",";
                    }else if(obj[key] instanceof RegExp){
                        // 如果属性是正则表达式，属性值只保留一对空大括号{}
                        result += "\"" + key + "\":{},";
                    }else if(typeof obj[key] == "undefined" || obj[key] instanceof Function){
                        // 如果属性值是undefined, 该属性被忽略。忽略方法。
                    }else if(obj[key] instanceof Array){
                        // 如果属性值是数组
                        result += "\"" + key + "\":[";
                        var arr = obj[key];
                        for(var item in arr){
                            if(typeof arr[item] == "string"){
                                // 如果数组项是String类型，需要加上双引号
                                result += "\"" + arr[item] + "\",";
                            }else if(arr[item] instanceof RegExp){
                                // 如果属数组项是正则表达式，只保留一对空大括号{}
                                result += "{},";
                            }else if(typeof arr[item] == "undefined" || arr[item] instanceof Function){
                                // 如果数组项是undefined, 则显示null。如果是函数，则显示null?。
                                result += null +",";
                            }else if(arr[item] instanceof Object){
                                //如果数组项是对象(非正则，非函数，非null)，调用本函数处理
                                result += this.stringify(arr[item]) +",";
                            }else{
                                result += arr[item] + ",";
                            }
                        }
                        result = result.slice(0,-1)+"],"
          
                    }else if(obj[key] instanceof Object){
                        // 如果属性值是对象(非null，非函数，非正则)，调用本函数处理
                        result += "\"" + key + "\":" + this.stringify(obj[key]) + ",";
                    }else{
                        result += "\"" + key + "\":" + obj[key] + ",";
                    }
                }
                // 去除最后一个逗号,两边加{}
                return "{" + result.slice(0,-1) + "}";
            }
        };
```


