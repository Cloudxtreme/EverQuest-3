title: 《DOM编程艺术》课堂交流问题汇总之基础篇
date: 2016-05-24 10:53
categories:

- Web前端
- JavaScript
tags:
- javascript
thumbnail: http://p2s7rr94e.bkt.clouddn.com/blog/180120/IjHEIKHif3.jpg
------

> 本课程为网易云课堂 - - 前端开发工程师 - - [《DOM编程艺术》](http://mooc.study.163.com/course/NEU-1000054004?tid=2001219008#/info)学习总结

### 问题一：实现浏览器兼容版的element.children

element.children能够获取元素的元素子节点，但是低版本的ie不支持，如何在低版本的ie上兼容类似的功能。

 **分析解答：**

思路：

-  写一个函数getElementChild(element),传入一个父节点element.

-  判断DOM中element对象的children属性是否存在，存在则直接返回element.children,不存在则执行兼容代码.

-  兼容代码思路：
  -  创建一个数组elementArr以便返回最终 [符合要求] 的子节点集合。
  -  调用element对象的childNodes属性，以获取其子节点集合。
  -  遍历子节点集合，对每一个子节点进行判断，如果节点类型为1（即节点类型为元素节点）,则添加到elementArr返回数组中。
  -  返回数组elementArr


解决代码：

```JavaScript
// nodeType=1 元素节点 nodeType=2 属性节点 nodeType=3 文本节点
function getElementChild(element){
    if (!element.children) {  //如果没有children方法
          var result_elementchild = [],    //新的元素子节点数组
          nodelist = element.childNodes;    //获取所有子节点
          for (var i = 0; i < nodelist.length; i++) {
              if(nodelist[i].nodeType == 1){        //判断节点是否为元素节点
                  result_elementchild.push(nodelist[i]);
                   }
               }
              return result_elementchild;
            } else {
              return element.children;
            }
}
```

### 问题二：实现浏览器兼容版的element.dataset

element.dataset能够获取元素的自定义属性，但是低版本的ie不支持，如何在低版本的ie上兼容类似的功能。

相关文章推荐：

-  [HTML data属性简介以及低版本浏览器兼容算法](http://blog.csdn.net/willspace/article/details/46859885) （很经典，不错的文章）

-  [HTML5自定义属性对象Dataset简介](http://www.zhangxinxu.com/wordpress/2011/06/html5%E8%87%AA%E5%AE%9A%E4%B9%89%E5%B1%9E%E6%80%A7%E5%AF%B9%E8%B1%A1dataset%E7%AE%80%E4%BB%8B/)

分析解答：

思路：

1. 找到元素中以data-开头的属性名，取到其名称。

2. 根据dataset的驼峰命名，将data-后面的名称以驼峰命名的方式得到对应的ID名称。

3. 构建ID名称和属性名称的键值对。

4. 使用var attribute = element.getAttribute(attributeName)方法，从键值对中找到ID对应的属性名作为attributeName得到其对应的属性值，然后赋值给对应的ID元素。 

解答：

```JavaScript
        function $(id){  
            return document.getElementById(id);  
        }  
        //正则表达式变换首字母大写  
         function replaceReg(str){   
               var reg = /\b(\w)|\s(\w)/g;   
               str = str.toLowerCase();   
               return str.replace(reg,function(m){return m.toUpperCase()})   
         }  
        //带兼容的函数  
        function get_dataset(ele){  
            if(ele.dataset)  
                return ele.dataset;  
            else{  
            //一下是兼容代码  
                var dataset = {};  
                var ele_split = ele.outerHTML.split(" ");  
                for(var i = 0,element; i < ele_split.length; i++)      
                {  
                    element = ele_split[i];  
                    if (element.substring(0,4) == "data") {   
                        if (element.indexOf(">") !=  -1) {   
                            element = element.split(">")[0];  
                        };  
                        ele_key=element.split("=")[0].slice(5);  
                        ele_value=element.split("=")[1].slice(1,-1);  
                        if(ele_key.indexOf("-") ==  -1){  
                            dataset[ele_key] = ele_value;  
                        }else{  
                            ele_keys=ele_key.split("-");  
                            ele_key=ele_keys[0];  
                            for(i=1;i<ele_keys.length;i++){  
                                ele_key+=replaceReg(ele_keys[i]);  
                            }                 
                        }  
                    };  
                }  
                return dataset;  
            }  
  
        }  
```

