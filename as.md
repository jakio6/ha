>先在最开头把markdown语法记下来  
>用" ^ "表示一个空格
>> 子引用:>>
>>> 再进去:>>>

>> 回来:>>

> 加个空行结束子引用再用对应个>回到上级

___

>+ 无序列表 :   -^  | \*^ | *^
	- 子列表: 在前面加一个tab或两个空格
	- tab 和空格可以对齐 有时候会有点麻烦
1. 有序列表	: 字母或数字.^开头
	2. 1. 在这个里面有序列表会变样
	2. 有序列表的子列表还算正常
	3. a. 这样的不行

___
2.  1. 在这个里面有序列表会变样
    2. 有序列表的子列表还算正常
	3. a. 这样的不行
	a. 在外面也不行,被骗了
    	1. 再进一级就可以了,马的还是不行这用的是数字的 
    	2. 列表里的分割线
    ___
- -^在这里变成了有序的
___


>- 引用	:> 现在就在引用里
``` 
代码	:``手动打断`
```

    前面加四个空格
	前加一个tab
___
> 
### 标题	:#^ - ######^从大到小 这是三号
- 水平分割线: ___|***|--- 其实好像是这三种符号随便配,三个星号暂时不知道怎么打呢
-*_
**加粗:2x2个星号护体**  
*斜体:1x2个星号护体*  
~~删除线:2x2个波浪线~护体~~  
`底纹:1x2个` `护体  
![图片: ![描述](地址)](bieting.top)   
[链接:]我给打乱一下顺序](链接)](bieting.top)  
表格 | 2 | 3 |  
-|  
里面|不写了用不上太麻烦


原来是 |在|blackquote里不能画表格|      ||
 :--- |:-: | -:|  
  在外面随便 |怎么  | 画 |
:-左对齐 | :-: | 右对齐-: |随便加|||||||
 打个竖杠就加个格子|好像最少两个||
 |||

第二个测试|
-|  
一个-就够了|
明暗变化|原来都有的-
补充说明下|原来开表格的时候前面也要先加个空行
不然不管用|在引用里就退出引用了

>脚注[^1] 
[^1]:[^n]配对[^n]:
[^n]配对[^n]:加脚注后引用没了>在带冒号的那个前面再加个>
> 注释:<!--注释  另一半--<反向打乱一下  
换行:末尾^^  
行首缩进:两个全角空格,不用
_ _ _

最后  
补充转义:\  
可以转这些

\|`|*|#|_|-|+|{}|[]|()|.|!
-|
___ 
## 语句
- 0或1个label打头
- label是后面紧跟一个冒号:的symbol:
- label前面和后面可以跟空白字符,但是在它的标志symbol和:之间不能有任何空白字符
- 可以是空语句
- 后可选择跟随一个key symbol来决定后面语句的类型
1. 伪指令	:dot打头 .
2. 指令		:letter打头 
- 每一行只能有一个lebel
``` 
label:     .directive    followed by something
another_label:           # This is an empty statement.
           instruction   operand_1, operand_2, …
```
## sections
大概的说, 一个section是一个连续的地址范围在这个地址范围内的所有所有数据都被用作同一种用途,比如有"read only"的section  
___
- 至少三个段
1. .data
2. .bss
3. .text 
___ 
>链接器ld读取特定程序的众多目标文件,然后把他们内容拼接成一个可执行文件  
当as生成生成目标文件时,该部分认为是从地址0开始的,而ld可以为这个程序分配出最终的地址,所以最终生成的程序各部分不会产生重叠(objdump as生成的的.o文件再对比一下ld生成的可执行文件可以看出差别)  
这个说法可能过于简单,但它足以说明as是怎样使用section的  
ld把程序中的字节块移到对应的执行地址,这些块被当作一个整体,就是说他们的长度和字节顺序是不会变的  
这样的一个固定整体就被称为section  
这个分配地址的过程就称为relocation,它的工作就是调节目标文件所涉及的地址使得它们指向合适的运行时地址

___
在目标文件内text section从地址0开始,然后后面是data section和bss section  
___
为了使ld能够知道在section重定位的时候改动哪里,如何改动,as在object file里写入了一些重定位需要的信息,为了进行重定位,每当目标文件中出现(引用?)地址(**reference to an address**)(大概是这个意思)的时候,ld需要知道这些:
- 这个对地址的引用是从目标文件中哪里开始的?
- 这个引用有多少个byte?
- 这个address指向哪个段?((address) - (start-address of section)是多大
- 这个地址引用是不是与程序指针关联?
>英语很重要啊,这个reference to an address搞得我晕呼呼的(**其实看什么都晕呼呼的**)

事实上,所有的地址都是以section+offset into section的形式给出的.  
进一步说,**as**生成的大多数表述都是这种section-relative类型的.
在这本手册里(as),用notation(记号)`{secname N}` 来表示`offset N into section secname`  
>别看漏了,不然会看不下去的:sweat:

除了`text,data,bss`这三个sections你还需要了解`absolute(独立,绝对) section` 在ld整合以分开的代码的时候,**absolute section中的地址不会被改动**,比如:  
地址{absolute 0}会被ld重定位到运行地址0,虽然链接器从不在链接之后安排具有重叠地址的两个部分程序的数据段，但根据定义，它们的绝对部分必须重叠.当程序以地址{绝对239 }在程序的任何其他部分运行时，程序的某部分部分中的地址{绝对239 }总是相同的地址。
>Although the linker never arranges two partial programs’ data sections with overlapping addresses after linking, by definition their absolute sections must overlap. Address {absolute 239} in one part of a program is always the same address when the program is running as address {absolute 239} in any other part of the program.

section的理念拓展到了undefined section.任何在汇编时时section未知的地址by definition会被定义成{undefined U} U在之后会被填充,由于numbers总是已定义的,,生成undefined address的唯一当法是mention(提及,声明)一个未定义的symbol,对命名的通用块的引用就是这样一个symbol:它的值在汇编时是未知的因此他是section undefined的  
在linked的程序中section指的是一组section,ld把所有部分代码的text sections放在linked程序中连续的地址区域,**当谈到一个程序的text section的时候,一般是指所有部分代码中text section的地址,data和bss section也是如此**  
有些section是由ld处理的,其他的是as使用的,只在汇编起作用  
___
