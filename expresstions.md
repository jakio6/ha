# expressions
一个expression指定了一个地址或者一个numeric value
(搜狗也出问题了...)expression的前后可能有空白字符,expression的结果必须是绝对数,或者是对特定section的offset,如果一个expression不是absolute的,并且在as看见这个expresstion的时候么有足够的信息去判断他的section,a second pass over the source program might be necessary to interpret the expression—but the second pass is currently not implemented. as aborts with an error message in this situation. 
## empty expresstion 
empty expresstion没有值:ta只由空白字符组成或者为null,当需要一个absolute expresstion的时候,你可能会忘掉他,这时as会猜测他的值为0,这与其他汇编器是一样的
##  interger expresstion
一个interger expresstion是由算子界定的一个或多个参数
### argument
arguments are symbols,numbers or subexpresstions,在别的情景下arguments有时也叫做算术操作数,在本手册中,为了防止将其机器语言中的指令操作数混淆,we use the term “argument” to refer to parts of expressions only,保留字operand来唯一指定机器指令操作数,

Symbols are evaluated to yield {section NNN} where section is one of text, data, bss, absolute, or undefined. NNN is a signed, 2’s complement 32 bit integer.

Numbers are usually integers. A number can be a flonum or bignum. In this case, you are warned that only the low order 32 bits are used, and as pretends these 32 bits are an integer. You may write integer-manipulating instructions that act on exotic constants, compatible with other assemblers. 

Subexpressions are a left parenthesis ‘(’ followed by an integer expression, followed by a right parenthesis ‘)’; or a prefix operator followed by an argument. 

### operators
operators是算数函数,想+或者%,prefix operators后跟一个expresstion,infix operators在两个字arguments中间, Operators may be preceded and/or followed by whitespace. 
### prefix operators
as支持一下prefix operators,他们都只带一个argument,这个argument必须是非负数
- `-`负 补码取反
- `~`complementation.按位取反

### infix operators
带两个arguments,左右各一个,operators有优先级,同等优先级的operations从左到右执行,除了`+`和`-`,所有的operations的arguments必须是非负的,而且结果也是非负的.

1. ...
2. Highest Precedence
	- `*`multipication
	- `/`division,truncation(截断)与c中的operator`/`是相同的
	- `%`remainder
	- `<<`shift left,与c中`<<`相同
	- `>>`shift right,与c中`>>`相同
3. intermediate precedence
 	- `|` bitwise inclusive(包括的,广泛的) or
 	- `&` bitwise and
 	- `^` bitwise exclusive or (异或)
 	- `!` bitwise or not
4. low precedence
	- `+`addtion 如果两个argument都是absolute的,the result has the section of the other argument.,不能对来自两个不同section的argument进行add运算
	- `-`subatraction.如果右边的argument是非负的,结果的section与左argument相同,如果两个argument在同一个section,结果是非负的,不能对对来自两个不同section的argument进行sub运算
	- `==` is equal to
	- `<>` `!=`is not equal to
	- `<` less than 
	- `>` is great than 
	- `>=` is great than or equal to
	- `<=`is less than or equal to   
比较运算符可以用作infix operators,`true`的结果值是`-1`,反之(whereas)`false`的结果值是`0`,注意,这些operators进行的是signed comparisons

5. lowest precedence
	- `&&` logical and
	- `||`logical or  
	这两个logical operation可以用来链接两个sub expresstion 的结果,注意,与comparison operators不同,`true`返回`1`,`false`的返回仍然是`0`,还需要注意的是,`||`的优先级比`&&`要略低一点

简而言之,只有同一个address的offset进行加减的时候才有意义;在两个argument中只能有一个定义的section