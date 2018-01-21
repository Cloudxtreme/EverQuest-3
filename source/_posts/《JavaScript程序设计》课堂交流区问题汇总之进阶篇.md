title: 《JavaScript程序设计》课堂交流问题汇总之进阶篇
date: 2016-05-18 22:03
categories:

- Web前端
- JavaScript
tags:
- javascript
thumbnail: http://p2s7rr94e.bkt.clouddn.com/blog/180120/AFDKa1g0L0.jpg
------

> 本课程为网易云课堂 - - 前端开发工程师 - - [《JavaScript程序设计》](http://mooc.study.163.com/course/NEU-1000054003#/info)学习总结

### 问题一：复制对象

&emsp;&emsp;通过课程学习我们知道，对象作为引用类型，使用运算符=时，只是复制了对象的地址。

&emsp;&emsp;比如如下代码

```JavaScript
    var obj1 = {a:1};
    var obj2 = obj1;
    obj2.a = 2; // 此时obj1.a ===
```

&emsp;&emsp;修改对象obj2同时会改变obj1，那么如果我们需要克隆出一个独立但属性、方法完全一样的对象，该如何实现？

&emsp;&emsp;**解答：**

-  使用for  in

```JavaScript
    var obj2=new Object(); 
    for(var p in obj) 
    { 
    var name=p;//属性名称 
    var value=obj[p];//属性对应的值 
    obj2[name]=obj[p]; 
    }
```

&emsp;&emsp;参考：[js中如何复制一个对象并获取其所有属性和属性对应的值](http://www.jb51.net/article/42350.htm)


-   定义一个clone方法来实现

```JavaScript
    function clone(myObj){  
      if(typeof(myObj) != 'object') return myObj;  
      if(myObj == null) return myObj;  
         
      var myNewObj = new Object();  
         
      for(var i in myObj)  
         myNewObj[i] = clone(myObj[i]);  
         
      return myNewObj;  
    }
```

-  通过object原型扩展实现

```JavaScript
 Object.prototype.Clone = function()  
    {  
        var objClone;  
        if ( this.constructor == Object ) objClone = new this.constructor();  
        else objClone = new this.constructor(this.valueOf());  
        for ( var key in this )  
         {  
            if ( objClone[key] != this[key] )  
             {  
                if ( typeof(this[key]) == 'object' )  
                 {  
                     objClone[key] = this[key].Clone();  
                 }  
                else  
                 {  
                     objClone[key] = this[key];  
                 }  
             }  
         }  
         objClone.toString = this.toString;  
         objClone.valueOf = this.valueOf;  
        return objClone;  
    }
```

&emsp;&emsp;参考：[js对象复制](http://www.cnblogs.com/spring4/archive/2012/03/29/2483708.html)

### 问题二：JS和强类型语言（比如C++）在类型方面的主要区别

&emsp;&emsp;**解答：**


&emsp;&emsp;**强类型定义语言**：强制数据类型定义的语言。也就是说，一旦一个变量被指定了某个数据类型，如果不经过强制转换，那么它就永远是这个数据类型了。举个例子：如果你定义了一个整型变量a,那么程序根本不可能将a当作字符串类型处理。强类型定义语言是类型安全的语言。

&emsp;&emsp;**弱类型定义语言**：数据类型可以被忽略的语言。它与强类型定义语言相反, 一个变量可以赋不同数据类型的值。强类型定义语言在速度上可能略逊色于弱类型定义语言，但是强类型定义语言带来的严谨性能够有效的避免许多错误。

&emsp;&emsp;**二者的区别**，在于计算时是否可以不同类型之间对使用者透明地隐式转换。从使用者的角度来看，如果一个语言可以隐式转换它的所有类型，那么它的变量、表达式等在参与运算时，即使类型不正确，也能通过隐式转换来得到正确地类型，这对使用者而言，就好像所有类型都能进行所有运算一样，所以这样的语言被称作弱类型。

&emsp;&emsp;与此相对，强类型语言的类型之间不一定有隐式转换（比如C++是一门强类型语言，但C++中double和int可以互相转换，但double和任何类型的指针之间


### 问题三：隐式类型转换场景

&emsp;&emsp;解答：

-  四则运算

&emsp;&emsp;加法运算符+是双目运算符，只要其中一个是String类型，表达式的值便是一个String。

&emsp;&emsp;对于其他的四则运算，只有其中一个是Number类型，表达式的值便是一个Number。

&emsp;&emsp;对于非法字符的情况通常会返回NaN：

```JavaScript
 '1' * 'a'     // => NaN，这是因为parseInt(a)值为NaN，1 * NaN 还是 NaN
```

-  判断语句

&emsp;&emsp;判断语句中的判断条件需要是Boolean类型，所以条件表达式会被隐式转换为Boolean。
 其转换规则同Boolean的构造函数。比如：

```JavaScript
    var obj = {};if(obj){
        while(obj);}
```

-  Native代码调用

&emsp;&emsp;JavaScript宿主环境都会提供大量的对象，它们往往不少通过JavaScript来实现的。 JavaScript给这些函数传入的参数也会进行隐式转换。例如BOM提供的alert方法接受String类型的参数：

```JavaScript
   alert({a: 1});    // => [object Object]
```
-   ==

&emsp;&emsp;JS的非严格匹配时会进行隐式类型转换。

### 问题四：识别类型方法

&emsp;&emsp;**解答：**


-  typeof : 可以识别除null之外的基本类型及对象类型，不能识别具体对象;
 ```   JavaScript
    typeof 1;//"number"
    typeof "1";//"string"
    typeof {};//"object"
    typeof [];//"object"
    typeof undefined;//"undefined";
    typeof null;//"object"
    typeof true;//"boolean"
 ```

-  instanceof : 可以识别Object类型和自定义类型，不能识别基本类型
```JavaScript
    [] instanceof Array;//true
    ({}) instanceof Object;//true
    (1) instanceof Object;//false
    (1) instanceof Number;//false
```
-   constructor : 识别除null和undefined的内置类型及自定义类型
```JavaScript
    (1).constructor===Number;//true
    "1".constructor===String;//true
```

- Object.prototype.toString().call(obj) : 可以识别标准类型以及内置对象类型；不能识别自定义对象类型；
```     JavaScript
    Object.prototype.toString().call(null);//"[object Null]"
    Object.prototype.toString().call(undefined);//"[object Undefined]"
```
-  组合封装函数
```JavaScript
  /*
   * 获取对象构造函数名称
   * 视频中关于getConstructorName函数写法存在bug，导致传入 0,   false, "", NaN 这些值时，得到错误的返回结果。
   * 1. 入参obj如果是undefined和null，则返回其自身;
   * 2. 入参obj如果是其他值，则返回obj.constructor&&obj.constructor.toString().match(/function\s*([^(]*)/)[1]的结果;
   */
   function getConstructorName(obj){
       return (obj===undefined||obj===null)?obj:(obj.constructor&&obj.constructor.toString().match(/function\s*([^(]*)/)[1]);
    }
```

### 问题五：函数声明和函数表达式定义同一个函数时，执行的是哪个？

```JavaScript
    // 以下代码执行时，三次打印分别输出什么？为什么？
     
    function add1(i){
      console.log("函数声明："+(i+1));
    }
    add1(1);
     
    var add1 = function(i){
      console.log("函数表达式："+(i+10));
    }
    add1(1);
     
    function add1(i) {
        console.log("函数声明："+(i+100));
    }
    add1(1);
```
&emsp;&emsp;**解析：**
```JavaScript
    function add1(i){
      console.log("函数声明："+(i+1));
    }
    add1(1);  //函数声明：101        因为函数声明会被预置到代码顶部，相同的声明后一个起作用，所以调用的是下页的那个函数声明
       
    var add1 = function(i){
      console.log("函数表达式："+(i+10));
    }
    add1(1); //函数表达式：11       因为函数声明已被同名函数表达式覆盖
       
    function add1(i) {
        console.log("函数声明："+(i+100));
    }
    add1(1); //函数表达式：11        因为函数声明已被同名函数表达式覆盖
```
```JavaScript
    //预解析如下
    var add1;
    function add1(i) {
        console.log("函数声明："+(i+100));
    }
    add1(1);
       
    add1 = function(i){
      console.log("函数表达式："+(i+10));
    }
    add1(1);
      
    add1(1);
```
&emsp;&emsp;**结果如下：**
```JavaScript
    函数声明：101
    函数表达式：11
    函数表达式：11
```

&emsp;&emsp;由于这两点，程序中第一个函数和第三个函数都被提升到了前面，由于函数名
相同，后一个覆盖前一个，所以起作用的只有第三个函数，同时第二个以表达式定义的函数的变量名add1也被提升到了程序的前面。 

&emsp;&emsp;当第一次调用由于变量add1还没有被定义，函数定义就会覆盖掉变量add1的声明，所以执行结果是调用第三个add函数；  当调用第二个add1时，变量add1已经被定义了，所以覆盖掉了函数声明， 所以之后调用add1执行的都是 以函数表达式定义的函数add1了。

### 问题六：对象方法中定义的子函数，子函数执行时this指向哪里？

三个问题：

    以下代码中打印的this是个什么对象？

    这段代码能否实现使myNumber.value加1的功能？

    在不放弃helper函数的前提下，有哪些修改方法可以实现正确的功能？

```JavaScript
    var myNumber = {
      value: 1,
      add: function(i){
        var helper = function(i){
            console.log(this);
              this.value += i;
        }
        helper(i);
      }
    }
    myNumber.add(1);
```
&emsp;&emsp;**解析：**

&emsp;&emsp;1. helper中的this指向Window全局变量

&emsp;&emsp;2. 不能。因为 myNumber.value并未增加

- 方法一：可以把helper调整为方法函数，这样helper就可以正确引用myNumber为this了。
```JavaScript
            var myNumber = {
                value:1,
                helper:function(i) {
                        console.log(this);
                        this.value +=i;
                },
                add: function(i) {
                    this.helper(i);
                }            
            }
        myNumber.add(1);
        console.log(myNumber.value);
```


-  方法二：使用闭包
```JavaScript
       var myNumber = {
            value: 1,
            add: function(i){
                var thisnew = this;
                // 构建闭包
                var helper = function(i){
                    console.log(thisnew);
                    thisnew.value += i;
                }
               helper(i);
             }
        }
```

-  方法三：使用方法调用模式，因为方法调用模式可以指向调用者
```JavaScript
    var myNumber = {
        value: 1,
        add: function(i){
            var helper = function(i){
                console.log(this);
                this.value += i;
            }
            // 新建一个o对象等于myNumber,将helper方法赋值给该对象，
            // 然后使用方法调用模式，这样可以让helper中的this指向调用者o,即myNumber
            var o = myNumber;
            o.fn = helper;
            o.fn(i);
        }
    }

```
-   方法四：使用apply（call）调用模式，将当前helper方法借用给myNumber对象使用，这样this指向的就是myNumber对象
```JavaScript
    var myNumber = {
        value: 1,
        add: function(i){
            var helper = function(i){
                console.log(this);
                this.value += i;
            }
            // myNumber对象借用helper方法，helper中的this将指向myNumber对象
            helper.apply(myNumber,[i]); //apply方法
            helper.call(myNumber,i);  //call方法
        }
    }
```

### 问题七：在变量作用域方面，函数声明和函数表达式有什么区别？

&emsp;&emsp;**解答：**

&emsp;&emsp;函数声明的执行环境为的上一层执行环境为window，函数表达式的上一层执行环境指向调用它的执行环境。
&emsp;&emsp;函数声明会是全局作用域，outer指向window，函数表达式在执行时才会解析，outer指向上一级函数环境。

### 问题八：闭包的应用场景有哪些？

&emsp;&emsp;**解答：**

&emsp;&emsp;闭包的应用场景主要有：保存函数的状态，性能优化和封装；

&emsp;&emsp;闭包有优点也有缺点，滥用闭包是非常不可取的，

&emsp;&emsp;使用闭包的注意点

&emsp;&emsp;1）由于闭包会使得函数中的变量都被保存在内存中，内存消耗很大，所以不能滥用闭包，否则会造成网页的性能问题，在IE中可能导致内存泄露。解决方法是，在退出函数之前，将不使用的局部变量全部删除。

&emsp;&emsp;2）闭包会在父函数外部，改变父函数内部变量的值。所以，如果你把父函数当作对象（object）使用，把闭包当作它的公用方法（Public Method），把内部变量当作它的私有属性（private value），这时一定要小心，不要随便改变父函数内部变量的值。

### 问题九：原型继承和类继承有什么区别？

&emsp;&emsp;**解答：**

&emsp;&emsp;原型继承和类继承是两种认知模式，本质上都是为了抽象（复用代码）。相对于类，原型更初级且更灵活。因此当一个系统内没有太多关联的事物的时候，用原型明显比用类更灵活便捷。

v原型继承的便捷性表现在系统中对象较少的时候，原型继承不需要构造额外的抽象类和接口就可以实现复用。（如系统里只有猫和狗两种动物的话，没必要再为它们构造一个抽象的“动物类”）

&emsp;&emsp;原型继承的灵活性还表现在复用模式更加灵活。由于原型和类的模式不一样，所以对复用的判断标准也就不一样，例如把一个红色皮球当做一个太阳的原型，当然是可以的（反过来也行），但显然不能将“恒星类”当做太阳和红球的公共父类（倒是可以用“球体”这个类作为它们的公共父类）。

### 问题十：实现一个Circle类

&emsp;&emsp;编程实现：



```
a.创建一个圆（Circle）的类，并定义该类的一个属性（半径）和两个方法（周长和面积），其中圆的半径可以通过构造函数初始化

b.创建圆的一个对象，并调用该对象的方法计算圆的周长和面积
```
&emsp;&emsp;**解答：**

```JavaScript
function circle(r){
    var cir = new Object();
    this.r = r;
    var perimeter = Math.PI * 2 * this.r;
    var area = Math.PI * this.r * this.r;
    cir.run = function(){
         return "圆的周长："+perimeter+" "+"圆的面积："+area;
    };
    return cir;
}
var cir1 = circle(2);
cir1.run();
//"圆的周长：12.566370614359172 圆的面积：12.566370614359172"
var cir2 = circle(3);
cir2.run();
//"圆的周长：18.84955592153876 圆的面积：28.274333882308138"
```

###问题十一：请使用Js代码写出一个类继承的模型

&emsp;&emsp;请使用Js代码写出一个类继承的模型，需包含以下实现：

```
定义父类和子类，并创建父类和子类的属性和方法
子类继承父类的属性和方法
在创建子类对象时，调用父类构造函数
```

&emsp;&emsp;**解答：**

```JavaScript
    function Car(brand){//父类构造器
      this.brand = brand;//定义父类属性
    }
    Car.prototype.getBrand = function(){//定义父类方法
      console.log(this.brand);
    };
    function Audi(owner){//子类构造器
      Car.call(this,"Audi");//继承并设置父类属性
      this.owner = owner;//定义子类属性
    }
    Audi.prototype = new Car();//设置子类原型为父类的一个实例，则子类原型的__proto__指向父类原型
    Audi.prototype.constructor = Audi;//设置子类的constructor为子类构造器
    Audi.prototype.getBrand = function(){
      Car.prototype.getBrand.call(this);//继承父类方法
    };
    Audi.prototype.getOwner = function(){//定义子类方法
      console.log(this.owner);
    }
      
    var a4 = new Audi("jhl");
    a4.getBrand();//Audi
    a4.getOwner();//jhl
```








