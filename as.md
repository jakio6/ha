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
马的什么玩意啊,看不下去了
___
### linker sections  
 
 section|...	  
 -|
 named text data|as与ld把他们看作分离但是同等的section.程序运行时,通常text section应该是不会改动的,text section通常是进程间共享的,它包含了指令和常量之类的.而data section在程序运行时通常是可更改的:比如C 语言的变量就会被存在data section.
 bss|在程序运行时,这个里头包含了置零的字节,用来存放存放未初始化的变量或者是common storage.每个程序bss section的长度是很重要的,但是由于它创建时就全部置零了,就没有必要再在目标文件中指定0填充字节了.bss section就是为了从目标文件中explicit(精简?)这些显式指定的0
 absolute|这个section的地址0总是被分配到运行时地址0,这在需要指定不被ld重分配的地址时很有用.从这个意义来,我们称absolute section是"unrelocatable"的:它们在重定位的时候不会改变
 undefined |这个section是对在前面的section中未出现的对象的地址引用的一个"catch-all"(缓存区?)
大概这么个意思:  
```
partial program # 1:  |ttttt|dddd|00|
                      +-----+----+--+

                      text   data bss
                      seg.   seg. seg.

                      +---+---+---+
partial program # 2:  |TTT|DDD|000|
                      +---+---+---+

                      +--+---+-----+--+----+---+-----+~~
linked program:       |  |TTT|ttttt|  |dddd|DDD|00000|
                      +--+---+-----+--+----+---+-----+~~

    addresses:        0 …
 ```
### Assembler internal sections
这些section在as内部使用,他们在运行时并没有意义,大多数情况下你并不需要去管这些section,但是在as的警告中可能会出现它们,所以大概了解一下他们对as的意义是很有用的,这些section用来使你程序中所有的expression 的地址可以是section relatived  
#### ASSEMBLER-INTERNAL-LOGIC-ERROR!
发现了assembler内部逻辑错误,这意味着assembler出现了bug  
#### expr section
assembler内部把复杂的expression以combinations of symbols表示,当需要用一个符号表示一条expression的时候,it puts it in the expr secion  
### sub-sections 
ok 到此为止 
____
# the end
接着来 
### sub-section
assembled bytes 通常会分到两个section:text和data.在named section中可能有一些数据是你最想向要在目标文件中将他们分配为contiguous的,即使他们在汇编汇编源代码中并非连续,as允许你用sub-section来实现这个目的,在每个section中,可以有标号0-8192的sub-section, `Objects assembled into the same subsection go into the object file together with other objects in the same subsection. (为什么中文输入法突然有些word输入buliaole cao) For example, a compiler might want to store constants in the text section, but might not want to have them interspersed with the program being assembled. In this case, the compiler could issue a ‘.text 0’ before each section of code being output, and a ‘.text 1’ before each group of constants being output. 
`  
`Subsections are optional. If you do not use subsections, everything goes in subsection number zero.`
`Each subsection is zero-padded up to a multiple of four bytes.(Subsections may be padded a different amount on different flavors of as.) `
* Subsections appear in your object file in numeric order, lowest numbered to highest.
* The object file contains no representation of subsections; ld and other programs that manipulate object files see no trace of them.They just see all your text subsections as a text section, and all your data subsections as a data section.
* To specify which subsection you want subsequent statements assembled into, use a numeric argument to specify it, in a ‘.text expression’ or a ‘.data expression’ statement.
# An expression specifies an address or numeric value. Whitespace may precede and/or follow an expression. 
>补充ha expression的意思,前面全mixed le

* If you just say ‘.text’ then ‘.text 0’ is assumed. Likewise ‘.data’ means ‘.data 0’. Assembly begins in text 0. 
 For instance:
 
```
 .text 0     # The default subsection is text 0 anyway.
.ascii "This lives in the first text subsection. *"
.text 1
.ascii "But this lives in the second text subsection."
.data 0
.ascii "This lives in the data section,"
.ascii "in the first data subsection."
.text 0
.ascii "This lives in the first text section,"
.ascii "immediately following the asterisk (*)."
```

#### .algin
Each section has a location counter incremented by one for every byte assembled into that section. Because subsections are merely a convenience restricted to as there is no concept of a subsection location counter. There is no way to directly manipulate a location counter—but the .align directive changes it, and any label definition captures its current value. The location counter of the section where statements are being assembled is said to be the active location counter. 
### bss section
用来存储局部公共变量,你可以在这里分配存储空间但不必初始化,程序运行时这里会被初始化为0
- **.lcomm**
- **.comm**
当生成支持多个section的目标文件,比如ELF和COFF时,你可以转到.bss section,正常的定义标志符, You may only assemble zero values into the section. Typically the section will only contain symbol definitions and .skip directives (see .skip). 
># pseudo-op 伪指令  
