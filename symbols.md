# 5 symbols 
---
>## symbols are a **central concept**(核心概念):
>程序员symbols用来命名,linker用symbol来帮助链接,而调试人员用symbol来调试
>### warning:
>> #### as does not place symbols in the object file in the same order they were declared. This may break some debuggers. 

> what happened to my keyboard ......
> 中文经常有子输不得
> 马各级

## labels
>> 换搜狗输入法了哈哈哈哈  
>> 还是有点不习惯呢 

label以一个symbol后跟一个:的形式出现,这之后这个symbol就代表了活跃location counter的当前值,他可以成为指令的操作数,如果你用同一个symbol去表示两个地址的话,它总代表第一个定义
>>> 在HPPA什么的上label的一般形式是:0开头  
>>> 每一行只能定义一个label,为了解决这个问题,HPPA版本的as提供了.label伪指令来更自由的定义label

## giving symbols other values 
通过`=expression`,一个symbol可以被任意赋值,这与使用***`.set`***伪指令是等价的,同样的使用`==`与***`.eqv`***等价
>blackfin`(好像是一款处理器)`不支持`=`

## symbol names 
symbol names 由字母或者`.` `_`中的一个开头,在多数机器上symbol names中可以使用`$`,那个字符(打头的?)可以跟由字母数字和`$`符号(有啥啥例外)还有下划线`_` (*区分大小写*)
>symbol names不能由数字打头,创建local labels的时候例外

支持multibyte characters(可以用中文?)要生成带multibytes characters的symbol name得把它用双引号引起来并且use escape code,Generating a multibyte symbol name from a label(带`:`的) is not currently supported.   
每个symbol都有唯一的name,汇编语言中的每个name都指向唯一的一个symbol,你可以在程序中不限次数地使用symbol name

### local symbol names
local symbol指的是以特定local label前缀开始的symbol,默认情况下,ELF体系的的前缀是`.L`,一般的`a.out`体系的前缀是`L`,每种特定的目标文件体系都可能有自己的一套,在HPPA上local symbols由`L$`打头.  
>local symbol是汇编器内部定义和使用的,通常并不会保存到目标文件中,因此在他们在调试时是不可见的,可以使用`-L`选项来在目标文件中保留这些local symbol
### local labels

与上头那个不同,local lebels可以帮助编译器和编程人员使用names temporarily,他会生成在输入代码中绝对唯一的symbol,这个symbol可以用一个简单的记号来表示,使用'`N:`'***(N表示任意非负整数)***形式的label 来定义local label,要引用那个label前最近的definetion,使用Nb(backwards),要引用一个lacal label后跟的definetion 使用Nf(forwards)
你使用多少个这样的label并没有限制,而且你也可以重复使用,所以可以重复的定义相同的local label(使用相同的N),尽管你只能使用特定local label前一次定义的值来进行backwards reference或者是用其下一定义来进行forwards reference.值得一提(it is also worth nothing?....)的是,使用前十个local label使用起来效率更高(短一些嘛),下面是例子:
```


1:        branch 1f
2:        branch 1b
1:        branch 2f
2:        branch 1b

Which is the equivalent of:

label_1:  branch label_3
label_2:  branch label_1
label_3:  branch label_4
label_4:  branch label_3
```
>好吧看到这里才发现理解错了,难怪感觉有点说不过去..

- lacal label names只是一个计数工具,它们会在被汇编程序员使用前转化成更加conventional的symbol names
+ symbol names存储在symbol table中,会出现在错误信息中,会被顺手(optionally emmited to)打包进目标文件中
the names由这几部分构成:  

哈哈|呵呵
-|
local label prefix|所有的local symbol都由系统特定 local label prefix打头,通常as和ld会忽视这些由local symbol前缀打头的symbol,这些label用于你不想看到的symbols,如果使用`-L`选项as会在目标文件中保留这些symbols,如果同事再使ld保留这些symbol的话,就可以在调试到时候使用
number|This is the number that was used in the local label definition. So if the label is written ‘55:’ then the number is ‘55’. 
C-B|这个特殊字符可以帮助避免出现不小心使用重名symbol的情况,这个字符的ASCII值是'\002'(ctrl +B)  
ordinary number|这是一系列用来用来区分label的数,比如:第一个`0:`此值是1,第十五个`0:`此值是15,另外的也是如此
所以举个例子,第一个 `1:`会被named `.L1C-B1`,第四十四个`3:`会被命名为`.L3C-B44`
### Dollar local labels
在一些目标文件平台下支持一种叫做dollar labels的更加local的local labels这些labels go out of scope(they become undefined)as soon as a non-local label is defined.因此它们仅在输入代码中一个小部分起作用,而一般的local labels会在整个输入代码中可见,或者是在他们被同名local label替代之前.  
Dollar labels实际上与local labels的定义方法相同,除了他们在numeric value后有个后缀`$`  
也可以从它们的转换名与local label区分开来,dollar local label使用ASCII字符'\001'(Ctrl+B)来与寻常label区分,比如:  
`6$:`的第十五次定义会被命名为`.L6C-A5`
## the special dot symbol
the special symbol '`.`'表示as正在装配的地址,因此,expression '`Melvin: .long .`'定义了melvin装载他自己的地址,为`.`分配地址与`.org`伪指令的处理方式相同,所以expression'`.=.+4`'与'`.space 4`'是相同的.
## symbol attributes
每个symbol包括它的'name'在内还有属性'value'和'type',取决于输出格式,symbols还可以有一些附加属性  
如果未指定属性就使用一个symbol,as会猜测所有这些属性值都是0,而且不会提示你,这使得这个symbol成为externally定义的symbol,这通常是你想要的.
- symbol value:value
- symbol type :type
- a.out symbols:Symbol Attributes: a.out
- COFF Symbols:	  	Symbol Attributes for COFF 
- SOM Symbols:	  	Symbol Attributes for SOM    
### value 
symbol 的value通常是32bit的.对于一个标记了text,data,bss或者absolute section中的位置的symbol来说,它的value就是从那个section开始到那个label的地址,通常对于text,data,bss section,symbol的值在ld更改section的基址会随着改变,absolute symbol的值在链接的时候不会改变,那也是为什么它叫做'absolute'  
	undefined symbol的值会被特殊处理,如果它的value是0那么这个symbol在汇编代码中就是未定义的,然后ld会尝试根据此程序其他部分代码来决定它的值.通过引用一个未定义的变量很容易可以制造这样一个symbol.  
    非0值代表`.comm`common声明,它的值取决于它所要保留内存,按字节来算.这个symbol指向分配空间的第一个地址.
### type
symbol的type属性包含了重定位(section)信息,暗示着一个symbol是否external的flag settings,还有(**可选的**)其他为linker和debugger准备的信息,具体格式取决于使用的目标文件输出格式.
### Symbol Attributes: a.out
#### Descriptor
This is an arbitrary 16-bit value. You may establish a symbol’s descriptor value by using a .desc statement (see .desc). A descriptor value means nothing to as.
#### Other
This is an arbitrary 8-bit value. It means nothing to as. 
### Symbol Attributes for COFF
COFF格式支持众多额外symbol属性,like the primary symbol attributes, they are set between .def and .endef directives. 
#### Primary Attributes
The symbol name is set with .def; the value and type, respectively(各自的), with .val and .type.
#### Auxiliary Attributes
The as directives .dim, .line, .scl, .size, .tag, and .weak can generate auxiliary symbol table information for COFF. 
### Symbol Attributes for SOM
The SOM format for the ***HPPA*** supports a multitude of symbol attributes set with the .EXPORT and .IMPORT directives.
The attributes are described in HP9000 Series 800 Assembly Language Reference Manual (HP 92432-90001) under the IMPORT and EXPORT assembler directive documentation. 